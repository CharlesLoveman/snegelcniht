class_name State extends Object

static func _on_physics_process(_entity, _delta, _state):
	pass

static func _on_transition(_entity, _state):
	pass

static func _on_timeout(_entity, _state):
	pass
	
static func _input(_event, _entity, _state):
	pass
	
static func grounded_dispatch(entity, state):
	if not entity.is_on_floor():
		entity.transition(Falling, state)
		return
	if abs(state["direction"].x) > 0.1:
		entity.transition(Walking, state)
		return
	if abs(entity.velocity.x) > 10.0:
		entity.transition(Sliding, state)
		return
	entity.transition(Standing, state)

static func update_firing(event: InputEvent, entity: Entity, state: Dictionary, cancel: bool) -> bool:
	if !state.has("firing"):
		state["firing"] = false
	if event.is_action_pressed("Fire"):
		state["firing"] = true
		if cancel:
			entity.transition(Attacking, state)
		return true
	elif event.is_action_released("Fire"):
		state["firing"] = false
		entity.get_node("AttackTimer").stop()
		return true
	return false

static func update_direction(event, state) -> bool:
	if !state.has("direction"):
		state["direction"] = Vector2.ZERO
	if event.is_action_pressed("Left"):
		state["direction"].x -= 1
		return true
	elif event.is_action_released("Left"):
		state["direction"].x += 1
		return true
	elif event.is_action_pressed("Right"):
		state["direction"].x += 1
		return true
	elif event.is_action_released("Right"):
		state["direction"].x -= 1
		return true
	elif event.is_action_pressed("Up"):
		state["direction"].y -= 1
		return true
	elif event.is_action_released("Up"):
		state["direction"].y += 1
		return true
	elif event.is_action_pressed("Down"):
		state["direction"].y += 1
		return true
	elif event.is_action_released("Down"):
		state["direction"].y -= 1
		return true
	return false
