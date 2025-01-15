extends Node2D
class_name pot
var original_pos= Vector2()

var clicked=false
var chopped=false


func _process(delta):
	if clicked==true:
		followMouse()

func _ready():
	original_pos=position
	$Timer.wait_time = 2 


func followMouse():
	position = get_global_mouse_position()


func _on_pot_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			clicked = true
		else:
			clicked = false

func _on_pot_area_entered(area):
	if area.name == "blender" and position==original_pos :
		$AnimatedSprite2D.play("guava_cook")

	if area.name == "guava":
		position=original_pos

	if area.name=="table":
		position=original_pos

	if area.name != "blender":
		position=original_pos

	if area.name=="knife":
		position=original_pos
	
	if area.name=="guava jam":
		$AnimatedSprite2D.play("empty")
		$Timer.wait_time = 7
		position=original_pos

func disabled():
	clicked = false

