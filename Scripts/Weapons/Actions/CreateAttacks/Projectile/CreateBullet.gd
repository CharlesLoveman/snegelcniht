class_name CreateBullet extends CreateProjectile

func _init():
	super(load("res://Projectiles/bullet.tscn"), 0.0, 0.0, 0.0, 1000.0, 0.0, 0.05, 0.1, "PROJECTILE", load("res://Sprites/Bullet.png"))
