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
	inventoryDisplay = $CanvasLayer/InventoryPanel/VBoxContainer/InventoryDisplay
	weaponDisplay = $CanvasLayer/InventoryPanel/VBoxContainer/WeaponDisplay
	inventoryDisplay.setup(inventory_columns, inventory)
	inventoryDisplay.connect("update_inventory", update_inventory)
	weaponDisplay.setup(inventory)

func _unhandled_input(event):
	input_source.add_input(event)

func update_inventory(x: Item, id: int):
	inventory[id] = x
	inventoryDisplay.setup(inventory_columns, inventory)
	weaponDisplay.setup(inventory)

func pickup(x: Pickup):
	for i in range(inventory.size()):
		if !inventory[i]:
			update_inventory(x.item, i)
			x.queue_free()
			break
