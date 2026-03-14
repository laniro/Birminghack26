extends Area2D

var direction

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	look_at(get_global_mouse_position())
	var angle = global_position.angle_to_point(get_global_mouse_position())
	rotate(PI/2)
	
func _on_timer_timeout() -> void:
	queue_free()
