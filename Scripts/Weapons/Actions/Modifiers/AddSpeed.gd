class_name AddSpeed extends Modifier

var delta_speed: float = 1000.0

func _init():
	super(load("res://Sprites/SpeedUp.png"))

func _clone():
	return AddSpeed.new()

func _modify(attack: Attack):
	var add_speed_func = func(x):
		return x + delta_speed
	attack._map_speed(add_speed_func)
