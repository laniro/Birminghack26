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
	
