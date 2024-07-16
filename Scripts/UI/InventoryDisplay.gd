class_name InventoryDisplay extends GridContainer

signal update_inventory
signal select

func clear():
	for n in get_children():
		n.queue_free()

func setup(cols: int, contents: Array[Item]):
	clear()
	self.columns = cols
	for i in range(contents.size()):
		if contents[i]:
			add_child(ItemDisplay.new(i, contents[i]))
		else:
			add_child(EmptyDisplay.new())

func insert(x: ItemDisplay, pos: Vector2) -> bool:
	var min_id: int = 0
	var min_val: float = 1000000000.0
	print(pos)
	for i in range(get_child_count()):
		var child = get_child(i)
		print("child ", i, ": ", child.global_position)
		var child_pos: Vector2 = child.global_position + 0.5 * child.size
		var dist: float = (child_pos - pos).length_squared()
		print(dist)
		if dist < min_val:
			min_val = dist
			min_id = i
	add_child(x)
	emit_signal("update_inventory", x.item, min_id)
	return true

func _on_action_clicked(itemDisplay):
	remove_child(itemDisplay)
	emit_signal("update_inventory", null, itemDisplay.id)
	emit_signal("select", itemDisplay)
