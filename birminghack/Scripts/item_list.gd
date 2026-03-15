extends ItemList

var arithmeticNum = 0
var multiplicativeNum = 0
var menuType = "off"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if menuType == "off":
		if arithmeticNum > 0:
			arithmeticNum -= 1
			showArithmetic()
		if multiplicativeNum > 0:
			multiplicativeNum -= 1
			showMultiplicative()
	else:
		if Input.is_action_just_pressed("Upgrade1"):
			idx_clicked(0)
		elif Input.is_action_just_pressed("Upgrade2"):
			idx_clicked(1)
		elif Input.is_action_just_pressed("Upgrade3"):
			idx_clicked(2)
		elif Input.is_action_just_pressed("Upgrade4"):
			idx_clicked(3)

func showArithmetic():
	arithmeticNum += 1
	if menuType == "off":
		menuType = "arithmetic"
		clear()
		add_item("(1) +1 Max Heath")
		add_item("(2) +10 Speed")
		visible = true
	
func showMultiplicative():
	multiplicativeNum += 1
	if menuType == "off":
		menuType = "multiplicative"
		clear()
		add_item("(1) +10% Max Heath")
		add_item("(2) +10% defence")
		add_item("(3) +1% Speed")
		visible = true

func idx_clicked(i):
	if menuType == "off":
		print("How?!")
	if menuType == "multiplicative":
		if i == 0:
			$"../../Player".upgrade("Heal",false,0.1)
		elif i== 1:
			$"../../Player".upgrade("Def",false,0.1)
		elif i== 2:
			$"../../Player".upgrade("Speed",false,0.01)
		else:
			multiplicativeNum += 1
		multiplicativeNum -= 1
	if menuType == "arithmetic":
		if i== 0:
			$"../../Player".upgrade("Heal",true,1)
		elif i== 1:
			$"../../Player".upgrade("Speed",true,10)
		else:
			arithmeticNum += 1
		arithmeticNum -= 1
	menuType = "off"
	visible = false
	clear()
	#get_tree().paused = false
	

func _on_item_selected(index: int) -> void:
	pass # Replace with function body.
