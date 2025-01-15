extends Node


func choppedguava(guava: Node, area: Node) -> void:
	guava._on_guava_area_entered(area)
	if area.name == "knife":
		resource.get_next_dialogue_line(dialouge.next_id)
