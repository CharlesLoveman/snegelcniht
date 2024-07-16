extends PanelContainer

func _input(event):
	if event.is_action_pressed("Inventory"):
		$Inventory.visible = !$Inventory.visible
		$Hotbar.visible = !$Hotbar.visible
