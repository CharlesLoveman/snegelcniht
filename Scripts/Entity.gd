class_name Entity extends CharacterBody2D

var speed: float
var air_speed: float
var jump_vel: float
var num_jumps: int
var max_jumps: int
var accel: float
var air_accel: float
var dash_duration: float
var dash_vel: float
var dash_direction: float
var num_airdashes: int
var max_airdashes: int
var airdash_vel: float
var airdash_duration: float
var fastfall: float
var walljump_vel: float
var damage_modifiers: Dictionary
var hp: float
var hp_max: float
var hp_regen: float
var stamina: float
var stamina_max: float
var stamina_regen: float
var mana: float
var mana_max: float
var mana_regen: float

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var state = Standing
var state_data = {"direction": Vector2.ZERO}

var input_source: InputSource
var inventory: Array[Item] = []
var inventory_slot: int = 0

signal take_damage
signal die

func _init(
	speed: float,
	air_speed: float,
	jump_vel: float,
	max_jumps: int,
	accel: float,
	air_accel: float,
	dash_duration: float,
	dash_vel: float,
	max_airdashes: int,
	airdash_vel: float,
	airdash_duration: float,
	fastfall: float,
	walljump_vel: float,
	input_source: InputSource,
	damage_modifiers: Dictionary,
	hp: float,
	hp_regen: float,
	stamina: float,
	stamina_regen: float,
	mana: float,
	mana_regen: float,
):
	self.speed = speed
	self.air_speed = air_speed
	self.jump_vel = jump_vel
	self.max_jumps = max_jumps
	self.num_jumps = max_jumps
	self.accel = accel
	self.air_accel = air_accel
	self.dash_duration = dash_duration
	self.dash_vel = dash_vel
	self.dash_direction = 0.0
	self.max_airdashes = max_airdashes
	self.num_airdashes = max_airdashes
	self.airdash_vel = airdash_vel
	self.airdash_duration = airdash_duration
	self.fastfall = fastfall
	self.walljump_vel = walljump_vel
	self.input_source = input_source
	self.damage_modifiers = damage_modifiers
	self.hp = hp
	self.hp_max = hp
	self.hp_regen = hp_regen
	self.stamina = stamina
	self.stamina_max = stamina
	self.stamina_regen = stamina_regen
	self.mana = mana
	self.mana_max = mana
	self.mana_regen = mana_regen

func _physics_process(delta):
	var event = input_source._get_input()
	while event:
		handle_input(event)
		event = input_source._get_input()
	hp = min(hp + hp_regen, hp_max)
	stamina = min(stamina + stamina_regen, stamina_max)
	mana = min(mana + mana_regen, mana_max)
	state._on_physics_process(self, delta, state_data)
	
func _on_timeout():
	state._on_timeout(self, state_data)
	
func _on_melee_hit():
	state._on_melee_hit(self, state_data)

func handle_input(event: InputEvent):
	state._input(event, self, state_data)

func transition(new_state, new_state_data = {}):
	state = new_state
	state_data = new_state_data
	state._on_transition(self, state_data)

func get_tile_data_under_feet(key):
	var tile_map: TileMapWrapper = $"../Map"
	return tile_map.get_tile_data($"FloorDetector".global_position, key)

func _take_damage(damage: float, damage_type: String):
	var modifier = 1.0
	if damage_modifiers.has(damage_type):
		modifier = damage_modifiers[damage_type]
	var actual_damage = damage * modifier
	hp -= actual_damage
	print(hp)
	if actual_damage > 0:
		emit_signal("take_damage", actual_damage)
	if hp <= 0:
		emit_signal("die")
		queue_free()
