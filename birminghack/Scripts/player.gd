extends Area2D

@export var speed = 400
@export var time = 100
@export var maxhalth = 1.0
@export var health = 1.0
@export var defense = 1
@export var trueDefense = 0
@export var exp = 0
@export var level = 0
var velocity = Vector2(0, 0)
var canSwing = true
var maxScore = 0
#var screensize

signal hit
signal shoot(pos)
signal swing(pos)
signal death

var orb_scene: PackedScene = load("res://Scenes/orb.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#screensize = get_viewport_rect().size
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector2(0, 0)
	# Gets speed
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
	#position = position.clamp(Vector2.ZERO, screensize)
	
	# Gets Rotation
	look_at(get_global_mouse_position())
	rotate(PI/2)
	
	if Input.is_action_just_pressed("summon"):
		summonOrb()
	
	if Input.is_action_just_pressed("shoot"):
		shoot.emit($BulletStart.global_position)
	if (Input.is_action_just_pressed("swing") && canSwing):
		swing.emit($BulletStart.global_position)
		canSwing = false
		$SwordCoolDown.start()

func onKill():
	time += 5
	maxScore = max(time, maxScore)

func _on_timer_timeout() -> void:
	time -= 1
	if time == 0:
		pass # Where we will add shift code
	
func gainExp(amount):
	exp += amount
	if (exp>10*(level+1)):
		exp-=10*(level+1)
		level+=1
		if level%5:
			$"..".openPopupBasic()
		else:
			$"..".openPopupBonus()
	updateExperienceBar()
	updateHealthBar()

func updateExperienceBar():
	$"../CanvasLayer/ExperienceBar".value = 100*exp/(10*(level+1))

func updateHealthBar():
	$"../CanvasLayer/HealthBar".value = 100*health/maxhalth
	print(health)

func Hit(damage, isTrue):
	var overallDefense = trueDefense
	if (!isTrue):
		overallDefense +=defense
	
	if (randf()<=1/overallDefense):
		health -= damage
	updateHealthBar()
	print(health)
	if (health == 0):
		death.emit(maxScore)
	
func heal(amount):
	health = min(maxhalth,health+amount)
	updateHealthBar()

func upgrade(type, isArithmetic, amount):
	if !isArithmetic:
		amount += 1
	
	if (type=="Def"):
		if (isArithmetic):
			defense += amount
		else:
			defense *= amount
	if (type=="MaxHeal"):
		if (isArithmetic):
			maxhalth += amount
			health+=amount
		else:
			maxhalth *= amount
			health*= amount
		updateHealthBar()
		
	if (type=="Speed"):
		if (isArithmetic):
			speed += amount
		else:
			speed *= amount

func summonOrb() -> void:
	var orb = orb_scene.instantiate()
	get_tree().current_scene.add_child(orb)
	orb.initiate(self)


func _on_area_entered(area: Area2D) -> void:
	if area.collision_layer == 2 && $HitTimer.is_stopped():
		hit.emit()

func _on_hit() -> void:
	_marcus()
	Hit(1,false)


func _on_sword_cool_down_timeout() -> void:
	canSwing = true

func _marcus() -> void:
	var hurt = load("res://Graphics/marcus_angry.png")
	$Sprite2D.texture = hurt
	$HitTimer.start(0.5)

func _on_hit_timer_timeout() -> void:
	var idle = load("res://Graphics/marcus_happy.png")
	$Sprite2D.texture = idle
	$HitTimer.stop()
