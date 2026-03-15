extends ProgressBar

var normalsbBg = StyleBoxFlat.new()
var normalsbFill = StyleBoxFlat.new()
var deathsbBg = StyleBoxFlat.new()
var deathsbFill = StyleBoxTexture.new()

var mode = "normal"

func _ready() -> void:
	normalsbBg.bg_color = Color("333333")
	normalsbFill.bg_color = Color("e54032")
	normalsbFill.corner_radius_top_right = 4
	normalsbFill.corner_radius_bottom_right = 4
	deathsbBg.bg_color = Color("333333")
	var pc = PackedColorArray([Color("4f9405"),Color("ff0000")])
	var pf = PackedFloat32Array([0.0, 1.0])
	var g = Gradient.new()
	g.offsets = pf
	g.colors = pc
	var g2 = GradientTexture1D.new()
	g2.gradient = g
	deathsbFill.texture=g2
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
