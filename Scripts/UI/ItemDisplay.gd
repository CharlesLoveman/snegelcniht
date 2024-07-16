class_name ItemDisplay extends TextureRect

signal item_clicked
signal item_released
var id: int
var item: Item

func _init(id: int, item: Item):
	self.id = id
	texture = item.icon
	custom_minimum_size = Vector2(64, 64)
	mouse_filter = Control.MOUSE_FILTER_STOP
	self.item = item

func _ready():
	connect("item_clicked", get_parent()._on_action_clicked)

func _gui_input(event):
	if event.is_action_pressed("Fire"):
		z_index = 2
		emit_signal("item_clicked", self)
