extends Node2D

@export var enemy_distance = 1500
@export var enemy_speed = 300
@export var magnet_chance: int = 100
var enemy_scene: PackedScene = load("res://Scenes/enemies.tscn")
var bullet_scene: PackedScene = load("res://Scenes/Bullet.tscn")
var sword_scene: PackedScene = load("res://Scenes/sword.tscn")
var xp_scene: PackedScene = load("res://Scenes/ExperienceOrb.tscn")
var magnet_scene: PackedScene = load("res://Scenes/Magnet.tscn")
var wave_count = 1
var player

enum PopupID{
	AMaxHealth,
	ADefense,
	MDefense,
	ASpeed,
	MSpeed
}

var _last_mouse_position

func _ready() -> void:
	player = get_node("/root/Game/Player")

func _on_timer_timeout() -> void:
	for n in range(log(wave_count)/log(2)):
		var enemy = enemy_scene.instantiate()
		var rng := RandomNumberGenerator.new()
		var rand_degs: int = rng.randi_range(0,360)
	
		var x: float = player.position.x + enemy_distance*cos(rand_degs*0.0174532)
		var y: float = player.position.y + enemy_distance*sin(rand_degs*0.0174532)
	
		enemy.position = Vector2(x,y)
		enemy.enemyspeed = enemy_speed
		enemy.player = player
		$Enemies.add_child(enemy)
		enemy.connect("killed", on_death)
	wave_count += 1

func on_death(pos):
	summonXP(pos)
	$Player.onKill() # update score

func summonXP(pos) -> void:
	var rng := RandomNumberGenerator.new()
	if rng.randi_range(1,magnet_chance) == 1:
		var magnet = magnet_scene.instantiate()
		$Drops.add_child(magnet)
		magnet.initiate(self)
		magnet.position = pos
	else:
		var xp = xp_scene.instantiate()
		$XP.add_child(xp)
		xp.initiate(self)
		xp.position = pos

func _on_player_shoot(pos: Variant) -> void:
	var bullet = bullet_scene.instantiate()
	bullet.position = pos
	$Weapons.add_child(bullet)

func _on_player_swing(pos: Variant) -> void:
	var sword = sword_scene.instantiate()
	sword.position = pos
	$Weapons.add_child(sword)

func _on_player_death(maxScore) -> void:
	$CanvasLayer/TextEdit.text = "You died Max Score: " + str(maxScore)
	$CanvasLayer/TextEdit.visible = true
	get_tree().paused = true
