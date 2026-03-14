extends Area2D


var player
var enemyspeed
var parent

signal collision

var xp_scene: PackedScene = load("res://Scenes/ExperienceOrb.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("/root/Game/Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var vector_to_player = player.position - position
	
	if vector_to_player.length() < 50: 
		summonXP()
		queue_free()
	
	vector_to_player = vector_to_player.normalized()
	
	var velocity = vector_to_player * delta * enemyspeed
	position += velocity


func _on_body_entered(body: Node2D) -> void:
	print("Body Entered")
	collision.emit()

func summonXP() -> void:
	var xp = xp_scene.instantiate()
	get_tree().current_scene.add_child(xp)
	xp.initiate(self)
