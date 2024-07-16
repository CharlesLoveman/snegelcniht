class_name Standing extends State

static func _on_physics_process(entity, _delta, state):
	if not entity.is_on_floor():
		entity.transition(Falling, state)
		return
	if abs(state["direction"].x) > 0.1:
		entity.transition(Dashing, state)
		return
	entity.velocity = Vector2.ZERO
	entity.move_and_slide()

static func _on_timeout(entity, state):
	if state["firing"]:
		entity.transition(Attacking, state)

static func _input(event, entity, state):
	if event.is_action_pressed("Jump"):
		entity.transition(JumpSquat, state)
		return
	elif event.is_action_pressed("Pickup"):
		var pickups = entity.get_node("Area2D").get_overlapping_bodies()
		if pickups.size() > 0:
			entity.pickup(pickups[0])
	elif update_direction(event, state):
		return
	elif update_firing(event, entity, state, true):
		return
