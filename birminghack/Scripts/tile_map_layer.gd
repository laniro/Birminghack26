extends TileMapLayer

var alt = FastNoiseLite.new()
var temp = FastNoiseLite.new()
var moisture = FastNoiseLite.new()

var poison_scene: PackedScene = load("res://Scenes/poison.tscn")

const CHUNK_SIZE = 128
const TILEDIM = 16
const CHUNKLOADTHRESHHOLD = 3000

const GRASS = Vector2(0,0)
const FOREST = Vector2(1,0)
const STONE = Vector2(0,1)
const PATH = Vector2(1,1)

@onready var player = $"../Player"

var generated_chunks = {}
var chunk_queue = []

func _ready() -> void:
	_initialize_noise()
	generated_chunk(Vector2(0,0))

func _physics_process(_delta: float) -> void:
	check_chunk_loading()
	process_chunk_queue()

func _initialize_noise():
	moisture.seed = randi()
	temp.seed = randi()
	alt.seed = randi()
	
func generated_chunk(chunk_pos:Vector2i):
	if chunk_pos in generated_chunks:
		return
	generated_chunks[chunk_pos] = true
	chunk_queue.append(chunk_pos)
	
func process_chunk_queue():
	while !chunk_queue.is_empty():
		var chunk_pos = chunk_queue.pop_front()
		var chunkoffset = chunk_pos * CHUNK_SIZE
		
		for x in range(CHUNK_SIZE):
			for y in range(CHUNK_SIZE):
				var wx = chunkoffset.x +x
				var wy = chunkoffset.y + y
				
				var a = alt.get_noise_2d(wx,wy)*30
				var m = moisture.get_noise_2d(wx,wy)*30
				
				var atlas = FOREST
				if (a<-2 and m<-6) or a>7:
					atlas = STONE
				elif m < 0:
					atlas = PATH
				elif m < 4:
					atlas = GRASS
					
				set_cell(Vector2i(wx,wy),0, atlas)
				
		for  i in range ((chunk_pos.x+chunk_pos.y)):
			var poi = poison_scene.instantiate()
			poi.position = Vector2i((chunk_pos.x*CHUNK_SIZE+randi_range(0,CHUNK_SIZE))*TILEDIM , (chunk_pos.y*CHUNK_SIZE+randi_range(0,CHUNK_SIZE))*TILEDIM)
			poi.permanent = true
			$"../Enemies".add_child(poi)
				
		

func check_chunk_loading():
	
	if not is_instance_valid(player):
		return
	var player_chunk = Vector2i(floor(player.global_position.x/(CHUNK_SIZE*TILEDIM)),floor(player.global_position.y/(CHUNK_SIZE*TILEDIM)))
	
	generated_chunk(player_chunk+Vector2i(-1,0))
	generated_chunk(player_chunk+Vector2i(1,0))
	generated_chunk(player_chunk+Vector2i(0,-1))
	generated_chunk(player_chunk+Vector2i(0,1))
	generated_chunk(player_chunk+Vector2i(-1,1))
	generated_chunk(player_chunk+Vector2i(1,1))
	generated_chunk(player_chunk+Vector2i(-1,-1))
	generated_chunk(player_chunk+Vector2i(1,-1))

	
	
	
	
