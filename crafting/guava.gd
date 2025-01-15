extends Node2D
class_name guava

var original_pos = Vector2()

signal chopped
signal blended
signal cooked_guava

var clicked = false
var is_chopped = false
var is_blended = false

var ingredient_name = "guava"

func _process(delta):
	if clicked:
		followMouse()

func _ready():
	original_pos = position

func followMouse():
	position = get_global_mouse_position()

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		clicked = event.pressed

func _on_guava_area_entered(area):
	if area.name == "knife" and not is_chopped:
		$AnimatedSprite2D.play("chopped")
		emit_signal("chopped") 
		is_chopped = true
	
	elif area.name == "blender" and is_chopped:
		emit_signal("blended")
		queue_free()
		is_blended = true

	elif (area.name == "pot" or area.name == "stove") and is_blended:
		position = original_pos
		emit_signal("cooked_guava")
		$Timer.start()
	
	else:
		position = original_pos
		$Timer.start()

func _on_timer_timeout():
	position = original_pos

func disabled():
	clicked = false

