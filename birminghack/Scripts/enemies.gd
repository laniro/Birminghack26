extends Area2D

var player
var enemyspeed
var parent

var xp_scene: PackedScene = load("res://Scenes/ExperienceOrb.tscn")

signal killed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("/root/Game/Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var vector_to_player = player.position - position
	
	vector_to_player = vector_to_player.normalized()
	
	var velocity = vector_to_player * delta * enemyspeed
	position += velocity

func summonXP() -> void:
	var xp = xp_scene.instantiate()
	get_tree().current_scene.add_child(xp)
	xp.initiate(self)

func kill():
	summonXP()
	killed.emit()
	queue_free()




func _on_area_entered(area: Area2D) -> void:
	queue_free()
