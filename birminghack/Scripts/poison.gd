extends Area2D

var damage = false
var permanent

func _ready() -> void:
	if !permanent:
		$Lifetime.start()

func _process(delta: float) -> void:
	if !permanent:
		$Base.modulate.a = $Lifetime.time_left/5
		$Cloud.modulate.a = $Lifetime.time_left/5

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
	queue_free()
