class_name Gun extends Weapon

func _init():
	super(100, 1000, 100, 1, 0.0, 0.0, 5, load("res://Sprites/Gun.png"))
	actions.append(CreateBullet.new())
	actions.append(AddSpeed.new())
	actions.append(AddDamage.new())
	actions.append(CreateBullet.new())
	setup()
