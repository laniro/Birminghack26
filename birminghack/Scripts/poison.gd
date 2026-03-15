extends Area2D

var character
var damage = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.collision_layer == 1:
		var damage = true
		character.Hit(1, true)
		$Tick.start()


func _on_area_exited(area: Area2D) -> void:
	var damage = false


func _on_tick_timeout() -> void:
	if damage:
		character.Hit(1, true)
		$Tick.start()


func _on_lifetime_timeout() -> void:
	queue_free()
