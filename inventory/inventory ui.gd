extends Control

@onready var inv: Inv = preload("res://inventory/playerinv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var slotsclass=preload("res://inventory/itemsuiinv.tscn")
@onready var quest_scene =   $"../../CanvasLayer2/quest_ui"

var iteminhand: itemstackui

var is_open = false
signal opened
signal closed

signal removed

func _ready():
	connectslots()
	inv.update.connect(update)
	update()
	close()

func connectslots():
	for i in range(slots.size()):
		var slot = slots[i]
		slot.index= i
		var callable = Callable(self, "onslotclicked")
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

func update():
	for i in range(min(inv.slots.size(), slots.size())):
		var inventoryslot: InvSlot = inv.slots[i]
		
		if !inventoryslot.item:continue
		
		var itemuiin: itemstackui = slots[i].itemstackui
		if !itemuiin:
			itemuiin = slotsclass.instantiate()
			slots[i].insert(itemuiin)
			
		itemuiin.slot = inventoryslot
		itemuiin.update()


func open():
	self.visible = true
	is_open = true
	opened.emit()
	quest_scene.visible=false

func close():
	visible = false
	is_open = false
	closed.emit()


func onslotclicked(slot):
	if slot.IsEmpty():
		if !iteminhand: return
		insertinslot(slot)
		return
	if !iteminhand:
		takefromslot(slot)
		return 
	if slot.itemstackui.slot.item.name == iteminhand.slot.item.name:
		stackitems(slot)
		return
	swapitems(slot)


func takefromslot(slot):
	iteminhand= slot.takeitem()
	add_child(iteminhand)
	updateinhand()

func removeitem():
	var item = iteminhand
	remove_child(iteminhand)
	removed.emit()
	iteminhand=null
	GameManager.do_save()
	

func insertinslot(slot):
	var item = iteminhand
	remove_child(iteminhand)
	
	iteminhand=null
	slot.insert(item)

func swapitems(slot):
	var tempitem = slot.takeitem()
	
	insertinslot(slot)
	iteminhand= tempitem
	add_child(iteminhand)
	updateinhand()


func stackitems(slot):
	var slotitem: itemstackui = slot.itemstackui
	var maxamt= slotitem.slot.item.maxAmountPrStack
	var totalamt= slotitem.slot.amount + iteminhand.slot.amount
	
	if slotitem.slot.amount == maxamt:
		swapitems(slot)
		return
	
	if totalamt <= maxamt:
		slotitem.slot.amount= totalamt
		remove_child(iteminhand)
		iteminhand= null
	else:
		slotitem.slot.amount = maxamt
		iteminhand.slot.amount= totalamt - maxamt
	
	slotitem.update()
	if iteminhand: iteminhand.update()



func updateinhand():
	if !iteminhand:return 
	iteminhand.global_position = get_global_mouse_position() - iteminhand.size/2


func _input(event):
	if event.is_action_pressed("Delete"):
		removeitem()
	updateinhand()

