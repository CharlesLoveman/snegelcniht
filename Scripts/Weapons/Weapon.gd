class_name Weapon extends Item

var actions: Array[Action] = []
var actions_per_attack: int = 1
var swing_delay: float = 0.0
var reload_delay: float = 0.0
var attack_delay: float = 0.0
var crit_rate: float = 0.0
var damage: float = 0.0
var speed: float = 0.0
var capacity: int

var action_queue: ActionQueue = ActionQueue.new()

func subscribe(_entity):
	pass

func _init(
	swing_delay: float,
	reload_delay: float,
	attack_delay: float,
	actions_per_attack: int,
	crit_rate: float,
	damage: float,
	capacity: int,
	icon: Texture2D
):
	super(icon)
	self.swing_delay = swing_delay
	self.reload_delay = reload_delay
	self.attack_delay = attack_delay
	self.actions_per_attack = actions_per_attack
	self.crit_rate = crit_rate
	self.damage = damage
	self.capacity = capacity

func setup():
	action_queue.setup(actions)

func attack(entity, state) -> Attack:
	var action_stack: Array[Action] = []
	if not state.has("swing_time") || not state.has("reload_time"):
		state["swing_time"] = 0
		state["reload_time"] = 0
	if Time.get_ticks_msec() < state["swing_time"] || Time.get_ticks_msec() < state["reload_time"]:
		return null
	var result = MultiAttack.new()
	for i in range(actions_per_attack):
		var action = action_queue.pop()
		if !action:
			break
		action_stack.append(action)
		while action_stack.size() > 1 || action_stack[0].attacks > 0:
			if action_stack.back().attacks > 0:
				action_stack.back().attacks -= 1
				action = action_queue.pop()
				if !action:
					continue
				action_stack.push_back(action)
			else:
				action = action_stack.pop_back()
				action_stack.back().add_child(action)
		result.add_attack(action_stack.pop_back()._apply(entity))
	if action_queue.wrapped:
		state["reload_time"] = Time.get_ticks_msec() + reload_delay
		action_queue.setup(actions)
	state["swing_time"] = Time.get_ticks_msec() + swing_delay
	return result

func _on_weapon_modified():
	action_queue.setup(actions)
