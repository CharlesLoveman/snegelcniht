class_name Projectile extends RigidBody2D

var damage: float
var damage_type: String
var crit_rate: float
var attacker: Object

var last_collision_pos: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", _on_collision)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Sprite2D.look_at(position + linear_velocity)

func _integrate_forces(state):
	if state.get_contact_count() > 0:
		last_collision_pos = state.get_contact_collider_position(0)
		last_collision_pos -= state.get_contact_local_normal(0)

func _on_collision(collider):
	if collider is TileMap:
		$"../Map".hit_tile(last_collision_pos, damage)
	elif collider is Entity:
		collider._take_damage(damage, damage_type)
	queue_free()
