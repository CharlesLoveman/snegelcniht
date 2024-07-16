class_name Attacking extends State

static func _on_physics_process(entity, delta, _state):
	entity.velocity.y += entity.gravity * delta
	entity.move_and_slide()

static func _on_transition(entity: Entity, state: Dictionary):
	if entity.inventory.size() == 0 || not entity.inventory[entity.inventory_slot] is Weapon:
		entity.transition(Falling, state)
		return
	var attack = entity.inventory[entity.inventory_slot].attack(entity, state)
	if attack:
		attack._execute(entity, state)
		var attack_timer = entity.get_node("AttackTimer")
		attack_timer.start((max(state["swing_time"], state["reload_time"]) - Time.get_ticks_msec()) / 1000.0)
		var timer: Timer = entity.get_node("OneShotTimer")
		timer.start(state["attack_time"])
		await timer.timeout
		if entity.state == Attacking:
			entity.transition(Falling, state)
	else:
		entity.transition(Falling, state)

static func _input(event: InputEvent, entity: Entity, state: Dictionary):
	update_direction(event, state)
	update_firing(event, entity, state, false)

static func _on_melee_hit(entity: Entity, state: Dictionary):
	state["swing_time"] = Time.get_ticks_msec() - 1
	state["reload_time"] = Time.get_ticks_msec() - 1
	entity.get_node("OneShotTimer").stop()
	entity.get_node("AttackTimer").stop()
	entity.get_node("OneShotTimer").start(0.01)
	entity.get_node("AttackTimer").start(0.01)
	print("melee_hit")
