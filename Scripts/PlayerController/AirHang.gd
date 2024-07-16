class_name AirHang extends State

const HANG_TIME = 0.05

static func _on_transition(entity, state):
	if entity.num_airdashes == 0:
		entity.transition(Falling, state)
		return
	entity.num_airdashes -= 1
	entity.velocity = state["direction"].normalized() * entity.airdash_vel
	var timer: Timer = entity.get_node("OneShotTimer")
	timer.start(HANG_TIME)
	await timer.timeout
	if entity.state == AirHang:
		entity.transition(AirDash, state)

static func _input(event: InputEvent, entity: Entity, state: Dictionary):
	update_direction(event, state)
	update_firing(event, entity, state, false)


