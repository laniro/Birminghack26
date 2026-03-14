extends Node2D

@export var enemy_distance = 1500
@export var enemy_speed = 300
var enemy_scene: PackedScene = load("res://Scenes/enemies.tscn")
var bullet_scene: PackedScene = load("res://Scenes/Bullet.tscn")
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

@onready var _pmA = $PopupMenu
@onready var _pmM = $PopupMenu2

func _ready() -> void:
	_pmA.add_item("+1 Max Heath",PopupID.AMaxHealth)
	_pmA.add_item("+5 Defense",PopupID.ADefense)
	_pmM.add_item("+10% Max Heath",PopupID.MDefense)
	_pmA.add_item("+5 Speed",PopupID.ASpeed)
	_pmM.add_item("+1% Speed",PopupID.MSpeed)
	player = get_node("/root/Game/Player")

func openPopupBasic():
	_pmA.popup()
	#_pm.popup(Rect2(_last_mouse_position.x,_last_mouse_position.y))
func openPopupBonus():
	_pmM.popup()
func id_pressed(i):
	if i == PopupID.AMaxHealth:
		$Player.upgrade("Heal",true,1)
	elif i== PopupID.ADefense:
		$Player.upgrade("Def",true,5)
	elif i== PopupID.MDefense:
		$Player.upgrade("Def",false,0.1)
	elif i== PopupID.ASpeed:
		$Player.upgrade("Speed",true,5)
	elif i== PopupID.MSpeed:
		$Player.upgrade("Speed",false,0.01)

func _on_timer_timeout() -> void:
	for n in range(log(wave_count)/log(2)):
		var enemy = enemy_scene.instantiate()
		var rng := RandomNumberGenerator.new()
		var rand_degs: int = rng.randi_range(0,360)
	
		var screen = Vector2(
			get_viewport().get_visible_rect().size[0],
			get_viewport().get_visible_rect().size[1]
		)
	
		var x: float = player.position.x + enemy_distance*cos(rand_degs*0.0174532)
		var y: float = player.position.y + enemy_distance*sin(rand_degs*0.0174532)
	
		enemy.position = Vector2(x,y)
		enemy.enemyspeed = enemy_speed
		enemy.player = player
		$Enemies.add_child(enemy)
		enemy.connect("collision", on_enemy_collision)
	wave_count += 1

func on_enemy_collision(dmg, isTrue):
	print("Enemy collided")
	$Player.Hit(dmg, isTrue)


func _on_player_shoot(pos: Variant) -> void:
	var bullet = bullet_scene.instantiate()
	bullet.position = pos
	$Bullets.add_child(bullet)
