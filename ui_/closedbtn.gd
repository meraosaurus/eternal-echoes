extends Control

@onready var quest_ui = $".."
@onready var setting_ui = $"."
@onready var inventory_ui = $"."
@onready var confectionary= $"."
@onready var close_btn =$closebtn


func close():
		confectionary.visible = false

func _on_closebtn_pressed():
	close()

func open_ui():
	confectionary.visible = true
	close_btn.visible = true
