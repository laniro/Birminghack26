extends Node2D

enum PopupID{
	AMaxHealth,
	ADefense,
	MDefense,
	ASpeed,
	MSpeed
}

var _last_mouse_position

@onready var _pmA = $PopupMenu
@onready var _pmM = $PopupMenu2

func _ready() -> void:
	_pmA.add_item("+1 Max Heath",PopupID.AMaxHealth)
	_pmA.add_item("+5 Defense",PopupID.ADefense)
	_pmM.add_item("+10% Max Heath",PopupID.MDefense)
	_pmA.add_item("+5 Speed",PopupID.ASpeed)
	_pmM.add_item("+1% Speed",PopupID.MSpeed)

func openPopupBasic():
	_pmA.popup()
	#_pm.popup(Rect2(_last_mouse_position.x,_last_mouse_position.y))
func openPopupBonus():
	_pmM.popup()
func id_pressed(i):
	if i == PopupID.AMaxHealth:
		$Player.upgrade("Heal",true,1)
	elif i== PopupID.ADefense:
		%Player.upgrade("Def",true,5)
	elif i== PopupID.MDefense:
		%Player.upgrade("Def",false,0.1)
	elif i== PopupID.ASpeed:
		%Player.upgrade("Speed",true,5)
	elif i== PopupID.MSpeed:
		%Player.upgrade("Speed",false,0.01)
