extends HSlider
class_name volume

@export var busname: String

var bus_index: int

func _ready():
	bus_index = AudioServer.get_bus_index(busname)
	value_changed.connect(value_changed_handler)
	
	
	value = db_to_linear(
		AudioServer.get_bus_volume_db(bus_index)
	)

func value_changed_handler(value: float):
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(value)
	)

func _on_mouse_exited():
	self.release_focus()

