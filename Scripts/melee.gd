class_name Melee extends Area2D

var damage: float
var damage_type: String
var crit_rate: float
var attacker: Entity

signal melee_hit

func setup():
	attacker.get_node("OneShotTimer").connect("timeout", _on_timeout)
	connect("melee_hit", attacker._on_melee_hit)

func _on_body_entered(collider):
	if collider is TileMap:
		pass
		#$"../../Map".hit_tile(last_collision_pos, damage)
	elif collider is Entity:
		collider._take_damage(damage, damage_type)
		emit_signal("melee_hit")
		queue_free()
		
func _on_timeout():
	queue_free()

