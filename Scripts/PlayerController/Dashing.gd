class_name Dashing extends State

static func _on_physics_process(entity, _delta, state):
	if not entity.is_on_floor():
		entity.transition(Falling, state)
		return
	entity.velocity.x = entity.dash_direction * entity.dash_vel;
	entity.move_and_slide()

static func _on_transition(entity, state):
	entity.dash_direction = state["direction"].x
	entity.velocity.x = entity.dash_direction * entity.dash_vel;
	var timer: Timer = entity.get_node("OneShotTimer")
	timer.start(entity.dash_duration)
	await timer.timeout
	if entity.state == Dashing:
		entity.transition(Landing, state)

static func _input(event, entity, state):
	if event.is_action_pressed("Jump"):
		entity.transition(JumpSquat, state)
		return
	elif event.is_action_pressed("Left"):
		state["direction"].x -= 1
		entity.transition(Dashing, state)
	elif event.is_action_pressed("Right"):
		state["direction"].x += 1
		entity.transition(Dashing, state)
	elif event.is_action_pressed("Pickup"):
		var pickups = entity.get_node("Area2D").get_overlapping_bodies()
		if pickups.size() > 0:
			entity.pickup(pickups[0])
	elif update_direction(event, state):
		return
	elif update_firing(event, entity, state, false):
		return
