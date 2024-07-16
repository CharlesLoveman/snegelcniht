class_name CreateMeleeAttack extends Attack

var projectile: PackedScene
var direction: Vector2
var range: float

func _init(
	projectile: PackedScene,
	swing_delay: float,
	reload_delay: float,
	attack_delay: float,
	damage: float,
	crit_rate: float,
	spread: float,
	direction: Vector2,
	damage_type: String,
	range: float
):
	super(swing_delay, reload_delay, attack_delay, 0.0, damage, crit_rate, spread, damage_type)
	self.projectile = projectile
	self.direction = direction
	self.range = range

func _execute(entity, state):
	super(entity, state)
	var obj = projectile.instantiate()
	entity.add_child(obj)
	obj.damage_type = damage_type
	obj.damage = damage
	obj.crit_rate = crit_rate
	obj.position = range * direction.normalized().rotated(randf_range(-spread / 2.0, spread / 2.0))
	obj.attacker = entity
	obj.look_at(entity.position + obj.position + direction)
	obj.setup()
