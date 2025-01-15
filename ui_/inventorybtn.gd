extends Control
@onready var quest_scene =   $"../../CanvasLayer2/quest_ui"
@onready var inventory_scene = $"../../CanvasLayer2/inventory ui"
@onready var setting_scene = $"../../CanvasLayer2/settings"
@onready var confectionary_scene=$"../../CanvasLayer/confectionary"
@onready var close_button = $"../../CanvasLayer2/inventory ui/close"

var is_open = false

func _ready():
	inventory_scene.visible = false
	close_button.visible = false


func _on_inventorybtn_pressed():
	if is_open:
		close()
	else:
		open()


func open():
	inventory_scene.visible = true
	close_button.visible = true
	is_open = true
	quest_scene.visible=false
	setting_scene.visible=false
	confectionary_scene.visible=false

func close():
	inventory_scene.visible = false
	setting_scene.visible = false
	is_open = false
	
func _process(delta):
	if Input.is_action_just_pressed("i"):  
		if is_open:
			close()
		else:
			open()
