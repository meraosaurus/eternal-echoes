extends Control
@onready var quest_scene =  $"../../CanvasLayer2/quest_ui"
@onready var inventory_scene = $"../../CanvasLayer2/inventory ui"
@onready var setting_scene = $"../../CanvasLayer2/settings"
@onready var confection_scence =$"../../CanvasLayer2/confectionary ui"
@onready var close_button = $"../../CanvasLayer2/confectionary ui/close"


var is_open = false
signal opened
signal closed

func _on_confectionary_button_pressed():
	if is_open:
		close()
	else:
		open()


func _ready():
	confection_scence.visible = false
	close_button.visible = false


func open():
	inventory_scene.visible = false
	close_button.visible = true
	is_open = true
	quest_scene.visible=false
	setting_scene.visible=false
	confection_scence.visible=true
	opened.emit()

func close():
	confection_scence.visible = false
	close_button.visible = false
	is_open = false
	closed.emit()
