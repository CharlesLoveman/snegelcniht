class_name CreateMelee extends CreateAttack

var projectile: PackedScene
var distance: float

func _init(
	proj: PackedScene,
	swing_delay: float,
	reload_delay: float,
	attack_delay: float,
	damage: float,
	crit_rate: float,
	spread: float,
	damage_type: String,
	distance: float,
	icon: Texture2D
):
	super(swing_delay, reload_delay, attack_delay, speed, damage, crit_rate, spread, damage_type, icon)
	projectile = proj
	self.distance = distance

func _apply(entity) -> Attack:
	#var direction = Input.get_vector("Left", "Right", "Up", "Down")
	var direction = entity.get_viewport().get_mouse_position() - entity.get_viewport().get_visible_rect().get_center()
	return CreateMeleeAttack.new(projectile, swing_delay, reload_delay, attack_delay, damage, crit_rate, spread, direction, damage_type, distance)

func _clone() -> Action:
	return CreateMelee.new(projectile, swing_delay, reload_delay, attack_delay, damage, crit_rate, spread, damage_type, distance, icon)
