extends Area2D

var direction
var swing_time = 0.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.wait_time = swing_time
	look_at(get_global_mouse_position())
	var angle = global_position.angle_to_point(get_global_mouse_position())
	
func _process(delta: float) -> void:
	$RadioSword.rotation += deg_to_rad(90*delta/swing_time)
	
func _on_timer_timeout() -> void:
	queue_free()
