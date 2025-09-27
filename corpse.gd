extends RigidBody2D

func _ready():
	# Prevent them from sliding forever by adding friction
	physics_material_override = PhysicsMaterial.new()
	physics_material_override.friction = 1.0
	physics_material_override.bounce = 0.0
