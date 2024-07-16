class_name ActionDisplay extends ColorRect

signal action_clicked
var id: int
var action: Action

func _init(id: int, action: Action):
	self.id = id
	color = action.color
	custom_minimum_size = Vector2(64, 64)

func _ready():
	connect("action_clicked", get_parent()._on_action_clicked)

func _gui_input(event):
	if event.is_action_pressed("Fire"):
		print("gui intercept")
		emit_signal("action_clicked", id)
