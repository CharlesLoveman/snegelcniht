class_name Attack extends Object
	
var swing_delay: float
var reload_delay: float
var attack_delay: float
var speed: float
var damage: float
var damage_type: String
var crit_rate: float
var spread: float

static func update_state(state, key, value):
	if not state.has(key):
		state[key] = 0.0
	state[key] = max(state[key] + value, 0.0)

func _init(
	swing_delay: float,
	reload_delay: float,
	attack_delay: float,
	speed: float,
	damage: float,
	crit_rate: float,
	spread: float,
	damage_type: String
):
	self.swing_delay = swing_delay
	self.reload_delay = reload_delay
	self.attack_delay = attack_delay
	self.speed = speed
	self.damage = damage
	self.damage_type = damage_type
	self.crit_rate = crit_rate
	self.spread = spread

func _map_swing_delay(f: Callable):
	swing_delay = f.call(swing_delay)

func _map_reload_delay(f: Callable):
	reload_delay = f.call(reload_delay)

func _map_attack_delay(f: Callable):
	attack_delay = f.call(attack_delay)
	
func _map_speed(f: Callable):
	speed = f.call(speed)

func _map_damage(f: Callable):
	damage = f.call(damage)

func _map_crit_rate(f: Callable):
	crit_rate = f.call(crit_rate)

func _map_spread(f: Callable):
	spread = f.call(spread)
	
func _map_damage_type(f: Callable):
	damage_type = f.call(damage_type)

func _execute(_entity, state):
	Attack.update_state(state, "swing_time", swing_delay)
	Attack.update_state(state, "reload_time", reload_delay)
	Attack.update_state(state, "attack_time", attack_delay)
