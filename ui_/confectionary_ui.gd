extends Control

@onready var inv: Inv = preload("res://inventory/playerinv.tres")
@onready var invslots = preload("res://inventory/inv_slot.gd")
@onready var slots: Array[InvSlot] = inv.slots
var guava = preload("res://inventory/items/guava.tres")  
var nutmeg = preload("res://inventory/items/nutmeg.tres")  

func _ready():
	update_buttons()

func update_buttons():
	if makegjam():
		$guavajambutton.disabled = false  
		
	else:
		$guavajambutton.disabled = true
		$"guavajambutton/items needed".add_theme_color_override("font_color", Color("#9e2826"))

func makegjam() -> bool:
	for inventory_slot in inv.slots: 
		if inventory_slot.item == guava and inventory_slot.amount>=2:
			return true
	return false


func remove_guava():
	for inventory_slot in inv.slots:
		if inventory_slot.item == guava and inventory_slot.amount>=2:
			inventory_slot.amount -=2
			if inventory_slot.amount == 0:
				inventory_slot.item = null
				inv.update.emit()
				GameManager.do_save()



func _on_guavajambutton_pressed():  
	remove_guava()
	get_tree().change_scene_to_file("res://crafting/cooking.tscn")
