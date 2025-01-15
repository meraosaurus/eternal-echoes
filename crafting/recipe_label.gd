extends Label

func show_next_instruction():
	if current_step < recipe_steps.size():
		instruction_label.text = recipe_steps[current_step]["step"]
	else:
		instruction_label.text = "Recipe Complete!"

