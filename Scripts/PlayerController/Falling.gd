class_name Falling extends State

const WALL_DELAY = 1000

static func _on_physics_process(entity, delta, state):
	if entity.is_on_floor():
		entity.transition(Landing, state)
		return
	if entity.is_on_wall():
		state["wall_time"] = Time.get_ticks_msec()
	entity.velocity.y += entity.gravity * delta
	var direction = Input.get_axis("Left", "Right")
	entity.velocity.x = min(entity.velocity.x + direction * entity.air_accel * delta, entity.air_speed)
	entity.move_and_slide()

static func _on_transition(entity, state):
	if !state.has("wall_time"):
		state["wall_time"] = 0
	if Time.get_ticks_msec() - state["wall_time"] < WALL_DELAY && sign(Input.get_axis("Left", "Right")) == sign(entity.get_wall_normal().x):
		entity.num_jumps += 1
	if Input.is_action_just_pressed("Jump") && entity.num_jumps > 0:
		entity.num_jumps -= 1
		entity.velocity.y = entity.jump_vel
		if Time.get_ticks_msec() - state["wall_time"] < WALL_DELAY && sign(Input.get_axis("Left", "Right")) == sign(entity.get_wall_normal().x):
			entity.velocity.x = entity.get_wall_normal().x * entity.walljump_vel * 0.5
		elif sign(entity.velocity.x) == -Input.get_axis("Left", "Right"):
			entity.velocity.x = 0
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
	elif event.is_action_pressed("Down"):
		entity.transition(FastFalling, state)
		state["direction"].y += 1
		return
	elif event.is_action_pressed("Pickup"):
		var pickups = entity.get_node("Area2D").get_overlapping_bodies()
		if pickups.size() > 0:
			entity.pickup(pickups[0])
	elif update_direction(event, state):
		return
	elif update_firing(event, entity, state, true):
		return
