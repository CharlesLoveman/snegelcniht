class_name WeaponActionDisplay extends GridContainer

var selected: int = -1
var weapon: Weapon

signal weapon_modified
signal select

func clear():
	for n in get_children():
		n.queue_free()

func setup():
	clear()
	columns = weapon.capacity
	for i in range(weapon.actions.size()):
		add_child(ItemDisplay.new(i, weapon.actions[i]))
	for i in range(weapon.actions.size(), weapon.capacity):
		add_child(EmptyDisplay.new())
	custom_minimum_size = Vector2(64 * columns, 96)

func insert(x: ItemDisplay, pos: Vector2) -> bool:
	if weapon.actions.size() == weapon.capacity:
		return false
	var min_id: int = 0
	var min_val: float = 1000000000.0
	for i in range(get_child_count()):
		var child = get_child(i)
		var child_pos: Vector2 = child.global_position + 0.5 * child.size
		var dist: float = (child_pos - pos).length_squared()
		if dist < min_val:
			min_val = dist
			min_id = i
	add_child(x)
	weapon.actions.insert(min(min_id, weapon.actions.size()), x.item)
	setup()
	emit_signal("weapon_modified")
	return true

func _init(weapon: Weapon):
	self.weapon = weapon
	connect("weapon_modified", weapon._on_weapon_modified)
	setup()

func _ready():
	connect("select", $"../../../..".select)

func _on_action_clicked(itemDisplay):
	remove_child(itemDisplay)
	weapon.actions.remove_at(itemDisplay.id)
	setup()
	emit_signal("weapon_modified")
	emit_signal("select", itemDisplay)
