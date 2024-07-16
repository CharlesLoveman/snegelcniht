class_name HotbarDisplay extends InventoryDisplay

func setup(cols: int, contents: Array[Item]):
	clear()
	self.columns = cols
	for i in range(cols):
		if contents[i]:
			add_child(ItemDisplay.new(i, contents[i]))
		else:
			add_child(EmptyDisplay.new())
