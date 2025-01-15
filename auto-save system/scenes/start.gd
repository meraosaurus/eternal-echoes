extends Node2D

func _ready() -> void:
	GameManager.do_load() 

func _on_btn_play_pressed()-> void:
	GameManager.do_save()
	GameManager.playing = true
	GameManager.autosave_start_time = Time.get_unix_time_from_system()
	GameManager.load_last_scene()
