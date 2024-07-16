class_name RandomInputSource extends InputSource

var inputs = {
	"Up": 0.05,
	"Down": 0.05,
	"Left": 0.25,
	"Right": 0.25,
	"Jump": 0.2,
	"Fire": 0.15,
	"Alt-Fire": 0.01,
	"AirDash": 0.04,
}

var input_state = {
	"Up": false,
	"Down": false,
	"Left": false,
	"Right": false,
	"Jump": false,
	"Fire": false,
	"Alt-Fire": false,
	"AirDash": false,
}

func _get_input() -> InputEvent:
	if randf() < 0.2:
		return null
	var x = randf()
	var sum = 0.0
	for key in inputs.keys():
		sum += inputs[key]
		if x < sum:
			var action = InputEventAction.new()
			action.action = key
			action.pressed = !input_state[key]
			input_state[key] = !input_state[key]
			return action
	return null
	
