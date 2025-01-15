extends Area2D

@export var item: InvtItem

func collect(inven:Inv):
	inven.insert(item)
	queue_free()
