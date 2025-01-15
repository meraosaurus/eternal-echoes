extends Node
@export var autosave_scene: PackedScene
@export var player_inventory: Inv  = preload("res://inventory/playerinv.tres")
var player_stats= preload("res://ui_/characterstats.gd")
var game_data: Dictionary
var autosave_length: int = 1
var autosave_start_time = 0 

var playing = false 
var player_x = 576
var player_y = 442.8003
var default_scene = "res://Levels/Level_1/grand etang alt.tscn"
var current_scene_path = null
var music
var playername:String=""

var sound
var busname:String
var current_volume_music
var current_volume_sound

func update_data():
	
	if player_stats.saved_text:
		playername = player_stats.saved_text
	else:
		playername = "Player"

	music = AudioServer.get_bus_index("music")
	current_volume_music= AudioServer.get_bus_volume_db(music)
	if current_volume_music == -INF:
		current_volume_music = -80
	
	sound = AudioServer.get_bus_index("sound")
	current_volume_sound= AudioServer.get_bus_volume_db(sound)
	if current_volume_sound == -INF:
		current_volume_sound = -80
	
	var current_scene = get_tree().current_scene
	if current_scene and not current_scene.scene_file_path.contains("start"):
		current_scene_path = current_scene.scene_file_path
		print("Saving scene path: ", current_scene_path)
		
		var inventory_data = []
		for slot in player_inventory.slots:
			var slot_data = {
				"amount": slot.amount,
				"item": slot.item.resource_path if slot.item else null
			}
			inventory_data.append(slot_data)
		
		game_data = {
			"player_data": {
				"posx": player_x,
				"posy": player_y,
				"lastscene": current_scene_path,
				"inventory": inventory_data,
				 "soundlevels": current_volume_sound,
				"musiclevels": current_volume_music,
				"name":playername
				
				
			},
			"options": {
				"autosave": autosave_length
			}
		}

func load_last_scene():
	print("Loading scene path: ", current_scene_path)
	if current_scene_path and not current_scene_path.contains("start"):
		get_tree().change_scene_to_file(current_scene_path)
	else:
		get_tree().change_scene_to_file(default_scene)


func do_save():
	
	update_data()
	
	var directory = "res://saved_game/"
	var file_path = directory + "game.dat"
	var dir = DirAccess.open("res://")
	if not dir.dir_exists(directory):
		dir.make_dir("saved_game")

	var file = FileAccess.open(file_path, FileAccess.WRITE)
	if file != null:
		var json = JSON.new()
		var json_string = json.stringify(game_data)
		file.store_line(json_string)
		file.close()
	else:
		print("Failed to open the file for writing.")
	print("Saved current game state")

func do_load() -> bool:
	if FileAccess.file_exists("res://saved_game/game.dat"):
		var file = FileAccess.open("res://saved_game/game.dat", FileAccess.READ)
		
		var test_json_conv = JSON.new()
		test_json_conv.parse(file.get_as_text())
		game_data = test_json_conv.get_data()
		
		file.close()
		
		var option_data = game_data["options"]
		var player_data = game_data["player_data"]
		
		# Load options
		autosave_length = option_data["autosave"]
		
		# Load player data
		player_x = player_data["posx"]
		player_y = player_data["posy"]
		if "name" in player_data:
			playername = player_data["name"]
		else:
			playername = "Player"
		 
		current_scene_path = player_data["lastscene"]
		
		sound = AudioServer.get_bus_index("sound")
		music = AudioServer.get_bus_index("music")
		
		AudioServer.set_bus_volume_db(sound, player_data["soundlevels"])
		AudioServer.set_bus_volume_db(music, player_data["musiclevels"])
		
		# Load inventory data
		if "inventory" in player_data:
			var inventory_data = player_data["inventory"]
			for i in range(min(inventory_data.size(), player_inventory.slots.size())):
				var slot_data = inventory_data[i]
				var slot = player_inventory.slots[i]
				slot.amount = slot_data["amount"]
				if slot_data["item"]:
					slot.item = load(slot_data["item"])
				else:
					slot.item = null
			player_inventory.update.emit()
		
		return true
	return false


func _physics_process(delta: float) -> void:
	if playing:
		autosave_logic()


func autosave_logic():
	var time_passed = Time.get_unix_time_from_system() - autosave_start_time
	if time_passed > (autosave_length * 60):
		do_save()
		autosave_start_time = Time.get_unix_time_from_system()
