extends Node2D

# Define the steps for the recipe
var guava_steps = [
	{"step": "Chop the guava", "action": "chop", "ingredient": "guava"},
	{"step": "put it in the blender!", "action": "blend", "ingredient": "guava"},
	{"step": "pour guava puree into the pot", "action": "pouring", "ingredient": "guava"},
	{"step": "pour sugar into the pot", "action": "pouring", "ingredient": "guava"},
	{"step": "cook over medium heat for 10-20 minutes (minutes will be seconds in the game)", "action": "pouring", "ingredient": "guava"},
	{"step": "pour into the jar ", "action": "pouring", "ingredient": "guava"}
]



var current_step = 0
var instruction_label

func show_next_instruction():
	if current_step < guava_steps.size():
		Label.text = guava_steps[current_step]["step"]
	else:
		Label.text = "Recipe Complete!"

func check_step(action, ingredient):
	var step = guava_steps[current_step]
	if action == step["action"] and ingredient == step["ingredient"]:
		current_step += 1  
		show_next_instruction()


func _ready():
	instruction_label = $Label
	show_next_instruction()
