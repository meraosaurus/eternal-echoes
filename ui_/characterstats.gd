extends Control
class_name playerstats

static var saved_text = ""

var focus_on

func _ready():
	GameManager.do_load()
	saved_text = GameManager.playername
	$Label.text = saved_text

func _on_label_text_submitted(new_text):
	saved_text = new_text
	GameManager.playername= saved_text
	focus_on=true
	onandoff()
	GameManager.do_save()
	$Label.text = saved_text


	print("your saved name is " , saved_text)




func _on_button_pressed():
	onandoff()
	


func onandoff():
	if focus_on ==true:
		$Label.release_focus()
		focus_on=false
		
	else:
		focus_on=true
		$Label.grab_focus()


func _input(event):
	if focus_on==false and event.is_action_pressed("right"):
		return
	elif focus_on==false and event.is_action_pressed("left"):
		return
	elif focus_on==false and event.is_action_pressed("ui_left"):
		return
	elif focus_on==false and event.is_action_pressed("ui_right"):
		return
