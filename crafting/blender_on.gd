extends Node2D
class_name blender

var clicked = false
var initial_rotation = 0
var original_pos = Vector2()
var guava_item = preload("res://crafting/guava.gd").new() 

func _ready():
	initial_rotation = rotation
	original_pos = position
	$Timer.wait_time = 2


	if not guava_item.is_connected("chopped", Callable(self, "on_guava_chopped")):
		guava_item.connect("chopped", Callable(self, "on_guava_chopped"))

func _process(delta):
	if clicked and $AnimatedSprite2D.animation == "guava":
		followMouse()

func followMouse():
	position = get_global_mouse_position()

func _on_blender_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			clicked = true
			rotation = deg_to_rad(-50)
		else:
			clicked = false
			rotation = initial_rotation

func _on_blender_area_entered(area):
	if area.name == "guava":
		$AnimatedSprite2D.play("guava")
		print("guava blender")
	else:
		$AnimatedSprite2D.play("empty") 
		print("please chop the guavas first")
	
	if area.name == "pot":
		$AnimatedSprite2D.play("empty")
		position = original_pos
		rotation = initial_rotation
		$Timer.start()

func _on_timer_timeout():
	rotation = initial_rotation
	position = original_pos

func on_guava_chopped():
	print("Guava was chopped!")
	guava_item.is_chopped = true

func disabled():
	clicked = false
