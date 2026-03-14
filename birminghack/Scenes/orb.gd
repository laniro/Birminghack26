extends Node2D

@export var rotationVelocity = 0

var parent
var reachedTarget := false
var target
var velocity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(randi_range(0, 1000),randi_range(0, 1000))
	rotation_degrees = randf_range(0.0, 360.0)
	rotationVelocity = randfn(0.0, 0.01)
	target = Vector2(randi_range(0, 1000),randi_range(0, 1000))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation += rotationVelocity
	position += velocity*delta
	# -0.1*delta change
	velocity = velocity-velocity*0.7*delta
	if position.x < target.x:
		velocity.x += 1
	elif position.x > target.x:
		velocity.x -= 1
	if position.y < target.y:
		velocity.y += 1
	elif position.y > target.y:
		velocity.y -= 1
	if reachedTarget:
		target = parent.position
		if position.distance_to(parent.position) < 50:
			queue_free()
	else:
		if position.distance_to(target) < 50:
			reachedTarget = true
			
