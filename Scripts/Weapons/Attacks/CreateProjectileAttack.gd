class_name CreateProjectileAttack extends Attack

var projectile: PackedScene
var direction: Vector2

func _init(
	projectile: PackedScene,
	swing_delay: float,
	reload_delay: float,
	attack_delay: float,
	speed: float,
	damage: float,
	crit_rate: float,
	spread: float,
	direction: Vector2,
	damage_type: String,
):
	super(swing_delay, reload_delay, attack_delay, speed, damage, crit_rate, spread, damage_type)
	self.projectile = projectile
	self.direction = direction

func _execute(entity, state):
	super(entity, state)
	var obj = projectile.instantiate()
	obj.damage_type = damage_type
	obj.damage = damage
	obj.crit_rate = crit_rate
	obj.position = entity.position
	var dir = direction.normalized().rotated(randf_range(-spread / 2.0, spread / 2.0))
	obj.apply_impulse(dir * speed)
	obj.attacker = entity
	entity.get_parent().add_child(obj)
