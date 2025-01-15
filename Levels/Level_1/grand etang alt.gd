extends Node2D

var location2 = "res://Levels/Level_1/grand etang alt.tscn"
var location1= "res://scenes/grandetangcabin.tscn"
var spawn_position =Vector2(373, 197)

func _ready():
	AudioPlayer.play_music_level()
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)

func _on_level_spawn(destination_tag:String):
	var door_path ="Doors/door_" + destination_tag
	var Door = get_node(door_path) as door


func _on_area_2d_body_entered(body):
	if body.has_method("player") and get_tree().current_scene:
		get_tree().change_scene_to_file(location1)
		GameManager.player_x= 373
		GameManager.player_y= 197
		GameManager.do_save()

func _on_area_2d_body_exited(body):
	if body.has_method("player") and get_tree().current_scene:
		get_tree().change_scene_to_file(location2)
		GameManager.player_x= 409.6
		GameManager.player_y= 282.4001
		GameManager.do_save()


func _on_inventory_ui_closed():
	get_tree().paused= false


func _on_inventory_ui_opened():
	get_tree().paused= true
