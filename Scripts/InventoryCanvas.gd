extends CanvasLayer

var selected: ItemDisplay

var inventoryDisplay: InventoryDisplay
var weaponDisplay: WeaponDisplay

# Called when the node enters the scene tree for the first time.
func _ready():
	inventoryDisplay = $InventoryPanel/VBoxContainer/InventoryDisplay
	weaponDisplay = $InventoryPanel/VBoxContainer/WeaponDisplay
	inventoryDisplay.connect("select", select)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if selected:
		selected.position = get_viewport().get_mouse_position() - 0.5 * selected.size
		if Input.is_action_just_released("Fire"):
			deselect()

func select(itemDisplay):
	selected = itemDisplay
	add_child(itemDisplay)
	selected.connect("item_released", deselect)

func deselect():
	remove_child(selected)
	var mouse_pos = get_viewport().get_mouse_position()
	var inv_rect = Rect2(inventoryDisplay.global_position, inventoryDisplay.size)
	var success: bool = true
	var panel_rect = Rect2($InventoryPanel.global_position, $InventoryPanel.size)
	if inv_rect.has_point(mouse_pos):
		print("inventory")
		success = inventoryDisplay.insert(selected, mouse_pos)
	elif panel_rect.has_point(mouse_pos):
		print("weapons")
		if selected.item is Action:
			if !weaponDisplay.insert(selected, mouse_pos):
				success = inventoryDisplay.insert(selected, mouse_pos)
		else:
			print("cant add non-action to weapon")
			success = inventoryDisplay.insert(selected, mouse_pos)
	else:
		success = false
	if !success:
		var pickup = Pickup.new(selected.item)
		$"../..".add_child(pickup)
		print($"..".position)
		pickup.position = mouse_pos - 0.5 * get_viewport().size + $"..".position
		#pickup.apply_impulse(mouse_pos - 0.5 * get_viewport().size)
	selected = null
