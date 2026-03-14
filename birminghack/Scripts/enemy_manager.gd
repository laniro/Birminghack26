extends Node2D


@export var enemy_distance = 50
@export var enemy_speed = 50
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


var enemy_scene: PackedScene = load("res://Scenes/enemies.tscn")
var wave_count = 1

func _on_timer_timeout() -> void:
	for n in range(log(wave_count)/log(2)):
		var enemy = enemy_scene.instantiate()
		var rng := RandomNumberGenerator.new()
		var rand_degs: int = rng.randi_range(0,360)
	
		var screen = Vector2(
			get_viewport().get_visible_rect().size[0],
			get_viewport().get_visible_rect().size[1]
		)
	
		var x: float = screen.x/2 + enemy_distance*cos(rand_degs*0.0174532)
		var y: float = screen.y/2 + enemy_distance*sin(rand_degs*0.0174532)
	
		enemy.position = Vector2(x,y)
		enemy.enemyspeed = enemy_speed
		$Enemies.add_child(enemy)
	wave_count += 1
