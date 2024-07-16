class_name CreateSwordSwing extends CreateMelee

func _init():
	super(load("res://Projectiles/sword_swing.tscn"), 0.1, 1.0, 0.1, 50.0, 0.05, 0.1, "SLASHING", 100.0, load("res://Sprites/Slash.png"))
