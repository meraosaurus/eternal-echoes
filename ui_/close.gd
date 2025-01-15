extends Control

@onready var quest_ui = $".."
@onready var setting_ui = $"."
@onready var inventory_ui = $"."
@onready var confectionary= $"."
@onready var close_btn = $closebtn
@onready var questbtn = get_node_or_null("../../../onscreen btns/questbtn")
@onready var settingsbtn = get_node_or_null("../../../onscreen btns/settingsbtn")
@onready var inventorybtn = get_node_or_null("../../../onscreen btns/inventorybn")
@onready var confectionarybtn = get_node_or_null("../../../CanvasLayer/confectionary")


var ui_elements = []

func _ready():
	ui_elements = [quest_ui, setting_ui, inventory_ui, confectionary]

func close():
	for ui in ui_elements:
		if ui:
			ui.visible = false
			

	if not questbtn:
		questbtn = get_node_or_null("../../../onscreen btns/questbtn")
	if not settingsbtn:
		settingsbtn = get_node_or_null("../../../onscreen btns/settingsbtn")
	if not inventorybtn:
		inventorybtn = get_node_or_null("../../../onscreen btns/inventorybn")
	

	if questbtn and questbtn.has_method("close"):
		questbtn.close()
	if settingsbtn and settingsbtn.has_method("close"):
		settingsbtn.close()
	if inventorybtn and inventorybtn.has_method("close"):
		inventorybtn.close()
	if confectionarybtn and confectionarybtn.has_method("close"):
		confectionarybtn.close()

func _on_closebtn_pressed():
	close()

func open_ui():
	for ui in ui_elements:
		if ui:
			ui.visible = true
	if close_btn:
		close_btn.visible = true
