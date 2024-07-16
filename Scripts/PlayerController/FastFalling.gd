class_name FastFalling extends State

static func _on_physics_process(entity, delta, state):
	if entity.is_on_floor():
		entity.transition(Landing, state)
		return
	if entity.is_on_wall():
		state["wall_time"] = Time.get_ticks_msec()
	entity.velocity.y += entity.gravity * delta * entity.fastfall
	entity.velocity.x = min(entity.velocity.x + state["direction"].x * entity.air_accel * delta, entity.air_speed)
	entity.move_and_slide()

static func _on_timeout(entity, state):
	if state["firing"]:
		entity.transition(Attacking, state)

static func _input(event, entity, state):
	if event.is_action_pressed("Jump"):
		entity.transition(Falling, state)
		return
	elif event.is_action_pressed("AirDash"):
		entity.transition(AirHang, state)
		return
	elif event.is_action_pressed("Pickup"):
		var pickups = entity.get_node("Area2D").get_overlapping_bodies()
		if pickups.size() > 0:
			entity.pickup(pickups[0])
	elif update_direction(event, state):
		return
	elif update_firing(event, entity, state, true):
		return
