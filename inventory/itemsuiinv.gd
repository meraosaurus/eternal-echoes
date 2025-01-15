extends Panel

class_name itemstackui

@onready var item_visual: Sprite2D = $itemdisplay
@onready var amount_text: Label= $Label

var slot: InvSlot

func _ready():
	update()

func update():
	if !slot || !slot.item: return 
	item_visual.visible = true
	item_visual.texture = slot.item.texture
	
	if slot.amount > 1:
		amount_text.visible = true
		amount_text.text = str(slot.amount)
	else:
		amount_text.visible = false
