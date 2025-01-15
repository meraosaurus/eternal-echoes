class_name van 
extends CharacterBody2D
var speed= 6

var player_state
var player_pos:Vector2

var village = "res://Levels/Level_1/village.tscn"
var grandetang = "res://Levels/Level_1/grand etang alt.tscn"

@export var inv:Inv
@onready var AnimatedSprite_2D: AnimatedSprite2D=$AnimatedSprite2D

func _physics_process(_delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction.x == 0 and direction.y == 0:
		player_state= "idle"
	elif direction.x != 0 or direction.y != 0:
		player_state= "walking"
	
	velocity = direction * speed
	move_and_slide()
	
	play_anim(direction)
	if player_pos!= global_position && player_state=="idle":
		print(global_position) 
		player_pos=global_position
		GameManager.player_x = global_position.x
		GameManager.player_y = global_position.y



func play_anim(direction):
	if player_state == "idle":
		$AnimatedSprite2D.play("idle")
	elif player_state == "walking":
		if direction.x == 1:
			$AnimatedSprite2D.play("e_walk")
			global_position.x += speed
			soundeffect()
		if direction.y == 1:
			$AnimatedSprite2D.play("s_walk")
			global_position.y += speed
			soundeffect()
		if direction.x == -1:
			$AnimatedSprite2D.play("w_walk")
			global_position.x -= speed
			soundeffect()
		if direction.y == -1:
			$AnimatedSprite2D.play("n_walk")
			global_position.y -= speed
			soundeffect()

func soundeffect(): #walking sound effects by me 
	if player_state=="walking":
		$AudioStreamPlayer.play()
	elif player_state!="walking" or player_state=="idle":
		$AudioStreamPlayer.stop()
		$AudioStreamPlayer.seek(-1)

func player():
	pass

func _ready():
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	global_position.x = GameManager.player_x
	global_position.y = GameManager.player_y
	player_pos= global_position 

func collect(item):
		inv.insert(item)

@warning_ignore("shadowed_variable_base_class")
func _on_spawn(position: Vector2, direction: String):
	AnimatedSprite_2D.play("walking"+direction)
	AnimatedSprite_2D.stop()
