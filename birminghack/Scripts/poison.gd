extends Area2D

var damage = false
var permanent = false
var life = 1.0

func _on_area_entered(area: Area2D) -> void:
	if area.collision_layer == 1:
		damage = true
		$Tick.start()


func _on_area_exited(_area: Area2D) -> void:
	damage = false


func _on_tick_timeout() -> void:
	if damage:
		$"../../Player".Hit(1, true)
		$Tick.start()


func _on_lifetime_timeout() -> void:
	life -= 0.1
	$Base.modulate.a = life
	$Cloud.modulate.a = life
	if !permanent && life == 0:
		queue_free()
	if !permanent:
		$Lifetime.start()
