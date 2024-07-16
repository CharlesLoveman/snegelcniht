class_name CreateProjectile extends CreateAttack

var projectile: PackedScene

func _init(
	proj: PackedScene,
	swing_delay: float,
	reload_delay: float,
	attack_delay: float,
	speed: float,
	damage: float,
	crit_rate: float,
	spread: float,
	damage_type: String,
	icon: Texture2D):
	super(swing_delay, reload_delay, attack_delay, speed, damage, crit_rate, spread, damage_type, icon)
	projectile = proj

func _apply(entity) -> Attack:
	#var direction = Input.get_vector("Left", "Right", "Up", "Down")
	var direction = entity.get_viewport().get_mouse_position() - entity.get_viewport().get_visible_rect().get_center()
	return CreateProjectileAttack.new(projectile, swing_delay, reload_delay, attack_delay, speed, damage, crit_rate, spread, direction, damage_type)

func _clone() -> Action:
	return CreateProjectile.new(projectile, swing_delay, reload_delay, attack_delay, speed, damage, crit_rate, spread, damage_type, icon)
