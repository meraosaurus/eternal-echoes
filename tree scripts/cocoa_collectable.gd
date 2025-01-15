extends StaticBody2D

func _ready():
	fallingfromtree()


func fallingfromtree():
	$AnimationPlayer.play("fallingfromtree")
	await get_tree().create_timer(9).timeout




func _on_area_2d_body_entered(body):
	print("+1 cocoas")
	visible=false
	$AnimationPlayer.play("fade")
	queue_free()
	
