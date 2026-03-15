extends Button

func _ready() -> void:
	$"..".process_mode = Node.PROCESS_MODE_ALWAYS
	$"../../CanvasLayer/ExperienceBar".visible = false
	$"../../CanvasLayer/HealthBar".visible = false
	get_tree().paused = true


func pressed():
	get_tree().paused = false
	print("fosaepguesohfe;fieosgfujbek;fbgs;ogfbsouifi;sohgfhx;goufsbdrogbudbfoso")
	$"..".visible = false
	$"../../CanvasLayer/ExperienceBar".visible = true
	$"../../CanvasLayer/HealthBar".visible = true
