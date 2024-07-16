class_name EmptyDisplay extends ColorRect

func _ready():
	color = Color.GRAY
	custom_minimum_size = Vector2(64, 64)
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)

func _on_mouse_entered():
	color = Color.BLUE

func _on_mouse_exited():
	color = Color.GRAY
