class_name JumpSquat extends State

const SQUAT_TIME = 0.067

static func _on_transition(entity, state):
	state["highjump"] = true
	var timer: Timer = entity.get_node("OneShotTimer")
	timer.start(SQUAT_TIME)
	await timer.timeout
	if entity.state == JumpSquat:
		entity.num_jumps -= 1
		entity.velocity.y = entity.jump_vel
		if state["highjump"]:
			entity.velocity.y *= 2
		entity.move_and_slide()
		entity.transition(Falling, state)

static func _input(event, entity, state):
	if event.is_action_released("Jump"):
		state["highjump"] = false
	if event.is_action_pressed("AirDash"):
		entity.transition(AirHang, state)
	elif update_direction(event, state):
		return
	elif update_firing(event, entity, state, true):
		return
