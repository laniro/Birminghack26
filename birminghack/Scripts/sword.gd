extends Area2D

var direction

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	look_at(get_global_mouse_position())
	var angle = global_position.angle_to_point(get_global_mouse_position())
	rotate(PI/2)
	if has_overlapping_areas():
		var enemies = get_overlapping_areas()
		for i in enemies:
			i.kill()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	area.kill()
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()
