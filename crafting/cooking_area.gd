extends Node2D
class_name cooking 
var dialouge=null


func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_accept"):
		
		return 

func _ready():
	var dialouge= await DialogueManager.show_dialogue_balloon(load("res://dialouge/guavacooking.dialogue"), "start")


