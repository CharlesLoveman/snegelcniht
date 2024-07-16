extends CanvasLayer

var selected: ItemDisplay

var inventoryDisplay: InventoryDisplay
var weaponDisplay: WeaponDisplay
var hotbarDisplay: HotbarDisplay

# Called when the node enters the scene tree for the first time.
func _ready():
	inventoryDisplay = $InventoryPanel/Inventory/InventoryDisplay
	weaponDisplay = $InventoryPanel/Inventory/WeaponDisplay
	hotbarDisplay = $InventoryPanel/Hotbar
	inventoryDisplay.connect("select", select)
	hotbarDisplay.connect("select", select)

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
	var inventory = inventoryDisplay
	if !$InventoryPanel/Inventory.visible:
		inventory = hotbarDisplay
	var inv_rect = Rect2(inventory.global_position, inventory.size)
	var success: bool = true
	var panel_rect = Rect2($InventoryPanel.global_position, $InventoryPanel.size)
	if inv_rect.has_point(mouse_pos):
		success = inventory.insert(selected, mouse_pos)
	elif panel_rect.has_point(mouse_pos):
		if selected.item is Action:
			if !weaponDisplay.insert(selected, mouse_pos):
				success = inventory.insert(selected, mouse_pos)
		else:
			success = inventory.insert(selected, mouse_pos)
	else:
		success = false
	if !success:
		var pickup = Pickup.new(selected.item)
		$"../..".add_child(pickup)
		pickup.position = $"..".global_position
		pickup.apply_impulse(mouse_pos - 0.5 * get_viewport().size)
	selected = null
