class_name AddDamage extends Modifier

var delta_damage: float = 11.0

func _init():
	super(load("res://Sprites/DamageUp.png"))
	
func _clone():
	return AddDamage.new()

func _modify(attack: Attack):
	var add_damage_func = func(x):
		return x + delta_damage
	attack._map_damage(add_damage_func)
