extends Area2D

@export var speed = 400
@export var time = 100
@export var maxhalth = 1
@export var health = 1
@export var defense = 0.1
<<<<<<< HEAD
@export var trueDefense = 0


var velocity = Vector2(0, 0)

=======
@export var trueDefense = 0.01
>>>>>>> 53a60468fe02bc93049b535c96158c8cf7766c27
var screensize

signal hit

var orb_scene: PackedScene = load("res://Scenes/orb.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screensize = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("moveUp"):
		velocity.y = -1
	elif Input.is_action_pressed("moveDown"):
		velocity.y = 1
	if Input.is_action_pressed("moveRight"):
		velocity.x = 1
	elif Input.is_action_pressed("moveLeft"):
		velocity.x = -1
	velocity = velocity.normalized() * speed
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screensize)
	velocity = Vector2(0, 0)
	
	if Input.is_action_pressed("summon"):
		summonOrb(Vector3(1,1,1))



func _on_body_entered(body: Node2D) -> void:
	hit.emit()

func onKill():
	time += 5

func _on_timer_timeout() -> void:
	time -= 1
	if time == 0:
		pass # Where we will add shift code
	

func Hit(damage, isTrue):
	var overallDefense = trueDefense
	if (!isTrue):
		overallDefense +=defense
	
	if (randf()>overallDefense):
		health -= damage
	
func heal(amount):
	health = min(maxhalth,health+amount)

func upgrade(type, isArithmetic, amount):
	if (type=="Def"):
		if (isArithmetic):
			defense += amount
		else:
			defense *= (1+amount)
	if (type=="MaxHeal"):
		if (isArithmetic):
			maxhalth += amount
		else:
			maxhalth *= amount
	if (type=="Speed"):
		if (isArithmetic):
			speed += amount
		else:
			speed *= amount
<<<<<<< HEAD

func summonOrb(colour) -> void:
	var orb = orb_scene.instantiate()
	get_tree().current_scene.add_child(orb)
	orb.parent = self
	orb.velocity = velocity
=======
			#
>>>>>>> 53a60468fe02bc93049b535c96158c8cf7766c27
