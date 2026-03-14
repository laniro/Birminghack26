extends Node2D

var value
var speed = 0
var player;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("/root/Game/Player")
	value = randf()*4

func initiate(parent):
	position = parent.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = (player.position - position).normalized()
	position += velocity * speed * delta


func _on_area_entered(area: Area2D) -> void:
	player.gainExp(value)
	queue_free()
