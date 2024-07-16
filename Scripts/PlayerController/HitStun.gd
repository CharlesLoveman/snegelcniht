class_name HitStun extends State

static func _on_physics_process(entity: Entity, delta: float, _state: Dictionary):
	entity.velocity.y += entity.gravity * delta
	entity.move_and_slide()

static func _on_transition(entity: Entity, state: Dictionary):
	var timer: Timer = entity.get_node("OneShotTimer")
	timer.start(state.timeout)
	await timer.timeout
	if entity.state == HitStun:
		entity.transition(Landing, state)

static func _input(event: InputEvent, entity: Entity, state: Dictionary):
	State.update_direction(event, entity, state)
	State.update_firing(event, entity, state, false)
