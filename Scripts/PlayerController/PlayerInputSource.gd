class_name PlayerInputSource extends InputSource

var events: Array[InputEvent] = []

func add_input(event: InputEvent):
	events.append(event)

func _get_input() -> InputEvent:
	return events.pop_front()
