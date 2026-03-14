extends Area2D

@export var speed = 400
var screensize

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screensize = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2(0, 0)
	if Input.is_action_pressed("moveUp"):
		velocity.y = 1
	elif Input.is_action_pressed("moveDown"):
		velocity.y = -1
	if Input.is_action_pressed("moveRight"):
		velocity.x = 1
	elif Input.is_action_pressed("moveLeft"):
		velocity.x = -1
	


@export var maxhalth = 1
@export var health = 1
@export var defense = 0.1
@export var trueDefense = 0

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
			defense *= amount
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
