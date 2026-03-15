extends Button

func _ready() -> void:
	$"..".process_mode = Node.PROCESS_MODE_ALWAYS
	$"../../CanvasLayer/ExperienceBar".visible = false
	$"../../CanvasLayer/HealthBar".visible = false
	$"../../Player".visible = false
	get_tree().paused = true


func pressed():
	get_tree().paused = false
	$"..".visible = false
	$"../../Player".visible = true
	$"../../CanvasLayer/ExperienceBar".visible = true
	$"../../CanvasLayer/HealthBar".visible = true
