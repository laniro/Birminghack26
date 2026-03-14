extends Node2D

var value
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = randf()*4

func initiate(parent):
	position = parent.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	area.gainExp(value)
	queue_free()
