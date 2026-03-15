extends Area2D

var character
var damage = false
var permanent = false
var life = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.collision_layer == 1:
		var damage = true
		$Tick.start()


func _on_area_exited(area: Area2D) -> void:
	var damage = false


func _on_tick_timeout() -> void:
	if damage:
		character.Hit(1, true)
		$Tick.start()


func _on_lifetime_timeout() -> void:
	life -= 0.1
	$Base.modulate.a = life
	$Cloud.modulate.a = life
	if !permanent && life == 0:
		queue_free()
	if !permanent:
		$Lifetime.start()
