class_name Modifier extends Action

const MAX_ATTACKS = 1

func _init(icon: Texture2D):
	super(icon)
	attacks = MAX_ATTACKS
	
func _clone():
	return Modifier.new(icon)

func _modify(_attack: Attack):
	pass

func _apply(entity) -> Attack:
	assert(children.size() <= MAX_ATTACKS)
	if children.size() == 0:
		return null
	var attack = children[0]._apply(entity)
	if !attack:
		return null
	_modify(attack)
	return attack
