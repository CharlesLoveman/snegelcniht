class_name WeaponDisplay extends VBoxContainer

func clear():
	for n in get_children():
		n.queue_free()

func setup(inventory: Array[Item]):
	clear()
	for item in inventory:
		if item is Weapon:
			var display = WeaponActionDisplay.new(item)
			add_child(display)

func insert(x: ItemDisplay, pos: Vector2) -> bool:
	var min_id: int = 0
	var min_val: float = 1000000000.0
	for i in range(get_child_count()):
		var child = get_child(i)
		var child_pos: Vector2 = child.global_position + 0.5 * child.size
		var dist: float = (child_pos - pos).length_squared()
		if dist < min_val:
			min_val = dist
			min_id = i
	return get_child(min_id).insert(x, pos)
