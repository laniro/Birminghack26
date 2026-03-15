extends Area2D

var player
var enemyspeed
var parent

signal killed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("/root/Game/Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var vector_to_player = player.position - position
	
	vector_to_player = vector_to_player.normalized()
	
	var velocity = vector_to_player * delta * enemyspeed
	position += velocity

func kill():
	killed.emit(position)
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	kill()
