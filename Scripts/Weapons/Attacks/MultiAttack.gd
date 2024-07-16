class_name MultiAttack extends Attack

var attacks: Array[Attack] = []

func _init():
	super(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, "NONE")

func add_attack(attack: Attack):
	if !attack:
		return
	attacks.append(attack)
	
func _map_swing_delay(f: Callable):
	for attack in attacks:
		attack._map_swing_delay(f)

func _map_reload_delay(f: Callable):
	for attack in attacks:
		attack._map_reload_delay(f)

func _map_attack_delay(f: Callable):
	for attack in attacks:
		attack._map_attack_delay(f)
	
func _map_speed(f: Callable):
	for attack in attacks:
		attack._map_speed(f)

func _map_damage(f: Callable):
	for attack in attacks:
		attack._map_damage(f)

func _map_crit_rate(f: Callable):
	for attack in attacks:
		attack._map_crit_rate(f)

func _map_spread(f: Callable):
	for attack in attacks:
		attack._map_spread(f)

func _execute(entity, state):
	super(entity, state)
	for attack in attacks:
		attack._execute(entity, state)
