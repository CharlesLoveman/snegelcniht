class_name CreateAttack extends Action

var speed: float
var spread: float
var crit_rate: float
var damage: float
var damage_type: String
var swing_delay: float
var reload_delay: float
var attack_delay: float

func _init(
	swing_delay: float,
	reload_delay: float,
	attack_delay: float,
	speed: float,
	damage: float,
	crit_rate: float,
	spread: float,
	damage_type: String,
	icon: Texture2D
):
	super(icon)
	self.swing_delay = swing_delay
	self.reload_delay = reload_delay
	self.attack_delay = attack_delay
	self.speed = speed
	self.damage = damage
	self.crit_rate = crit_rate
	self.spread = spread
	self.damage_type = damage_type

func _apply(_entity) -> Attack:
	return null
	
func _clone() -> Action:
	return CreateAttack.new(swing_delay, reload_delay, attack_delay, speed, damage, crit_rate, spread, damage_type, icon)
