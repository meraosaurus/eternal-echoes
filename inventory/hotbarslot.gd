extends Button

@onready var item_stack_ui: itemstackui = $CenterContainer/Panel


func update_to_slot(slot:InvSlot)-> void:
	if !slot.item:
		item_stack_ui.visible = false
		return
	item_stack_ui.slot= slot
	item_stack_ui.update()
	item_stack_ui.visible = true
