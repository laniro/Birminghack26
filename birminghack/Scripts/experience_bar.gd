extends ProgressBar

var normalsbBg = StyleBoxFlat.new()
var normalsbFill = StyleBoxFlat.new()
var deathsbBg = StyleBoxFlat.new()
var deathsbFill = StyleBoxFlat.new()

var mode = "normal"

func _ready() -> void:
	normalsbBg.bg_color = Color("999999")
	normalsbFill.bg_color = Color("44dd3399")
	normalsbFill.corner_radius_top_right = 4
	normalsbFill.corner_radius_bottom_right = 4
	deathsbBg.bg_color = Color("ff2211")
	deathsbFill.corner_radius_top_right = 4
	deathsbFill.corner_radius_bottom_right = 4
	deathsbFill.bg_color = Color("44dd33")
	add_theme_stylebox_override("fill", normalsbFill)
	add_theme_stylebox_override("background", normalsbBg)
	
func switchMode(m):
	mode = m
	if mode == "death":
		add_theme_stylebox_override("fill", deathsbFill)
		add_theme_stylebox_override("background", deathsbBg)
	else:
		add_theme_stylebox_override("fill", normalsbFill)
		add_theme_stylebox_override("background", normalsbBg)
