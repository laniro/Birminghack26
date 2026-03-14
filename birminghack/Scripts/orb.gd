extends Node2D

@export var rotationVelocity = 0

var parent
var reachedTarget := false
var target
var velocity = Vector2(0,0)
@export var lifetime = 15 #seconds (handily)
var ttl = lifetime

var images = [preload("res://Graphics/Orb1.png"),
preload("res://Graphics/Orb2.png"),
preload("res://Graphics/Orb3.png"),
preload("res://Graphics/Orb4.png"),
preload("res://Graphics/Orb5.png"),
preload("res://Graphics/Orb6.png"),]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(0,0)
	rotation_degrees = randf_range(0.0, 360.0)
	rotationVelocity = randfn(0.0, 0.01)
	target = get_global_mouse_position()
	$Sprite.texture = images.pick_random()

func initiate(p):
	parent = p
	position = parent.position
	velocity = parent.velocity
	velocity += Vector2.from_angle(deg_to_rad(randf_range(0,360)))*200

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ttl -= 1*delta
	
	rotation = velocity.angle()
	rotation_degrees += 90 
	position += velocity*delta
	# -0.1*delta change
	velocity = velocity-velocity*0.4*delta
	var posDelta = position-target
	posDelta = posDelta*0.01 # *(speed)
	velocity -= posDelta
	
	if reachedTarget:
		target = parent.position
		if position.distance_to(parent.position) < 50:
			queue_free()
	else:
		if (position.distance_to(target) < 200 && position.distance_to(parent.position) > 100):
			reachedTarget = true
	if ttl <=0:
		queue_free()
