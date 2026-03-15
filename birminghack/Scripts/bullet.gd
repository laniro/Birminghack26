extends Area2D

var direction
@export var speed = 600

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	look_at(get_global_mouse_position())
	var angle = global_position.angle_to_point(get_global_mouse_position())
	direction = Vector2(cos(angle), sin(angle))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta


func _on_area_entered(_area: Area2D) -> void:
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()
