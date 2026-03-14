extends Node2D

var value
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = randf()*4

func initiate(parent):
	position = parent.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player = get_node("/root/Game/Player")
	if position.distance_to(player.position) < 50:
		player.gainExp(value)
		queue_free()
