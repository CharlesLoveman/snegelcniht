class_name Player extends Entity

var inventory_columns: int = 5
var inventory_rows: int = 3

var selected: ItemDisplay = null

signal create_attack
signal update_player
signal delete_attack
signal hit_player

var inventoryDisplay: InventoryDisplay
var weaponDisplay: WeaponDisplay
var hotbarDisplay: HotbarDisplay

func _init():
	super(
		800.0,
		600.0,
		-400.0,
		2,
		1000.0,
		800.0,
		0.1,
		1000.0,
		1,
		800.0,
		0.1,
		5.0,
		600.0,
		PlayerInputSource.new(),
		{},
		100.0,
		0.0,
		100.0,
		1.0,
		0.0,
		0.0,
	)

func _ready():
	for i in range(inventory_rows):
		for j in range(inventory_columns):
			inventory.append(null)
	inventory[0] = Gun.new()
	inventory[1] = Sword.new()
	inventoryDisplay = $CanvasLayer/InventoryPanel/Inventory/InventoryDisplay
	weaponDisplay = $CanvasLayer/InventoryPanel/Inventory/WeaponDisplay
	hotbarDisplay = $CanvasLayer/InventoryPanel/Hotbar
	inventoryDisplay.setup(inventory_columns, inventory)
	inventoryDisplay.connect("update_inventory", update_inventory)
	hotbarDisplay.setup(inventory_columns, inventory)
	hotbarDisplay.connect("update_inventory", update_inventory)
	weaponDisplay.setup(inventory)
	
func _physics_process(delta):
	super(delta)
	$Sprite2D.flip_h = get_local_mouse_position().x < 0

func _unhandled_input(event):
	input_source.add_input(event)

func update_inventory(x: Item, id: int):
	var prev_item = inventory[id]
	inventory[id] = x
	if prev_item && x:
		var flag = true
		for i in range(inventory.size()):
			if !inventory[i]:
				inventory[i] = prev_item
				flag = false
				break
		if flag:
			var pickup = Pickup.new(prev_item)
			$"..".add_child(pickup)
			pickup.position = global_position
	inventoryDisplay.setup(inventory_columns, inventory)
	hotbarDisplay.setup(inventory_columns, inventory)
	weaponDisplay.setup(inventory)

func pickup(x: Pickup):
	for i in range(inventory.size()):
		if !inventory[i]:
			update_inventory(x.item, i)
			x.queue_free()
			break
