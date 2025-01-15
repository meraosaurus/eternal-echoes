extends Button

@onready var cont: CenterContainer = $CenterContainer
@onready var inventor = preload("res://inventory/playerinv.tres")

var itemstackui: itemstackui
var index: int

func insert(stack: itemstackui):
	itemstackui = stack
	cont.add_child(itemstackui)

	if !itemstackui.slot or inventor.slots[index] == itemstackui.slot:
		return

	inventor.insertslot(index, itemstackui.slot)

func takeitem():
	var item = itemstackui
	inventor.removeslot(itemstackui.slot)
	cont.remove_child(itemstackui)
	itemstackui = null

	return item

func IsEmpty():
	return !itemstackui
