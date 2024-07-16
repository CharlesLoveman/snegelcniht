class_name AirDash extends State

static func _on_physics_process(entity: Entity, _delta: float, _state: Dictionary):
	entity.move_and_slide()

static func _on_transition(entity: Entity, state: Dictionary):
	var timer: Timer = entity.get_node("OneShotTimer")
	timer.start(entity.airdash_duration)
	await timer.timeout
	if entity.state == AirDash:
		entity.transition(Falling, state)

static func _input(event: InputEvent, entity: Entity, state: Dictionary):
	update_direction(event, state)
	update_firing(event, entity, state, true)
