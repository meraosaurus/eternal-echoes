extends Control

var is_open = false
signal opened
signal closed

@onready var quest_scene =   $"../../CanvasLayer2/quest_ui"
@onready var inventory_scene = $"../../CanvasLayer2/inventory ui"
@onready var setting_scene = $"../../CanvasLayer2/settings"
@onready var close_button = $"../../CanvasLayer2/settings/close2"

func _ready():
	setting_scene.visible = false
	close_button.visible = false


func open():
	quest_scene.visible = false
	inventory_scene.visible=false
	setting_scene.visible=true
	close_button.visible = true
	is_open = true
	opened.emit()

func close():
	setting_scene.visible = false
	close_button.visible = false
	is_open = false
	closed.emit()



func _on_settingsbtn_pressed():
	if is_open:
		close()
	else:
		open()
