extends Panel

@onready var Inventory: Inv = preload("res://inventory/playerinv.tres")
@onready var slots: Array = $container.get_children()
@onready var selector :Sprite2D= $selector

var currentsel:int = 0
var iteminhand: itemstackui

func _ready():
	update()
	Inventory.update.connect(update)

func move_selector() -> void:
	currentsel =(currentsel + 1) % slots.size()
	selector.global_position= slots[currentsel].global_position
func update() -> void:
	for i in range(slots.size()):
		var inventory_slots: InvSlot = Inventory.slots[i]
		slots[i].update_to_slot(inventory_slots)



func _unhandled_input(event) -> void:
	if event.is_action_pressed("moveselector"):
		move_selector()



