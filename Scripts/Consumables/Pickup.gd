class_name Pickup extends RigidBody2D

var item: Item

func _init(item: Item):
	self.item = item
	var sprite = Sprite2D.new()
	add_child(sprite)
	sprite.texture = item.icon
	var collisionShape = CollisionShape2D.new()
	add_child(collisionShape)
	collisionShape.shape = RectangleShape2D.new()
	collisionShape.shape.size = Vector2(64, 64)
	collision_layer = 0b100000
	collision_mask = 0b10000
