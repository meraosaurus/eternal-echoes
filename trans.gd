extends Area2D
class_name door

@export var destination_level_tag: String
@export var destination_door_tag: String
@export var spawn_direction = "up"
@onready var spawn = $Spawn

func _on_body_entered(body):
	if body is van and get_tree().current_scene.scene_file_path.contains("Village"):
		GameManager.do_save()
		NavigationManager.go_to_level(destination_level_tag, destination_door_tag)
		GameManager.player_x = 77.93877
		GameManager.player_y = 2930.415
		GameManager.do_save()
	elif body is van and get_tree().current_scene.scene_file_path.contains("grand etang alt"):
		GameManager.do_save()
		NavigationManager.go_to_level(destination_level_tag, destination_door_tag)
		GameManager.player_x = 139.0096
		GameManager.player_y = -839.4642
		GameManager.do_save()
