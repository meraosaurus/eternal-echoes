extends Node2D

func _on_guava_jam_area_entered(area):
	if area.name =="pot":
		$AnimatedSprite2D.play("fill")
		$AnimatedSprite2D.play("finished")
