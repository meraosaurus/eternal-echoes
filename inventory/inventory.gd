extends Resource
class_name Inv
signal update

@export var slots: Array[InvSlot]
var index: int

func insert(item: InvtItem):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():
		itemslots[0].amount += 1
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
	update.emit()

func removeslot(inventoryslot: InvSlot):
	@warning_ignore("shadowed_variable")
	var index = slots.find(inventoryslot)
	if index < 0: return
	slots[index] = InvSlot.new()
	update.emit()

func insertslot(index: int, invslot: InvSlot):
	slots[index] = invslot
	update.emit()


func removeitems(index):
	if index < 0 or index >= slots.size() or not slots[index].item:return
	slots[index] = InvSlot.new()
	update.emit()
