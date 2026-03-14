extends Node2D

var player;
@export var xp_speed = 500;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("/root/Game/Player")

func initiate(parent):
	position = parent.position


func _on_area_entered(area: Area2D) -> void:
	for xp_orb in get_node("/root/Game/XP").get_children():
		xp_orb.speed = xp_speed;
	queue_free()
