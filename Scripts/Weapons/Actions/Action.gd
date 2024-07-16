class_name Action extends Item

var attacks: int = 0
var children: Array[Action] = []

func _init(icon: Texture2D):
	super(icon)

func add_child(action: Action):
	children.append(action)

func _clone() -> Action:
	var obj = Action.new(self.icon)
	for child in children:
		obj.add_child(child._clone())
	obj.attacks = attacks
	return obj

func _apply(entity) -> Attack:
	var attack = MultiAttack.new()
	for child in children:
		attack.add_attack(child._apply(entity))
	return attack
