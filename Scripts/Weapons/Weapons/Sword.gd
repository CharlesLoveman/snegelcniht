class_name Sword extends Weapon

func _init():
	super(0.1, 0.5, 0.1, 1, 0.0, 0.0, 3, load("res://Sprites/Sword.png"))
	actions.append(CreateSwordSwing.new())
	setup()
