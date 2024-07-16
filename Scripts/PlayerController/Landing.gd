class_name Landing extends State

static func _on_transition(entity, state):
	entity.num_jumps = entity.max_jumps
	entity.num_airdashes = entity.max_airdashes
	grounded_dispatch(entity, state)
