class_name ActionQueue extends Object

var actions: Array[Action] = []
var can_draw: bool
var wrapped: bool
var action_head: int

func setup(actions: Array[Action]):
	self.actions = []
	for action in actions:
		self.actions.append(action._clone())
	can_draw = actions.size() > 0
	action_head = 0
	wrapped = false

func pop() -> Action:
	if !can_draw:
		return null
	var action = actions[action_head]._clone()
	action_head += 1
	if action_head >= actions.size():
		if wrapped:
			can_draw = false
		wrapped = true
		action_head = 0
	return action
