extends Node2D
class_name knife

var clicked=false
var action= "chop"
var original_pos= Vector2()

func _ready():
	original_pos=position

func _process(delta):
	if clicked==true:
		followMouse()

func followMouse():
	position = get_global_mouse_position()


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			clicked = true
		else:
			clicked = false


func _on_area_2d_area_entered(area):
	if area.name == "guava":  
		print("chopped guava")
		position=original_pos
		$Timer.start()
	if area.name != "guava": 
		position=original_pos


func _on_timer_timeout():
	position=original_pos

func disabled():
	clicked = false

