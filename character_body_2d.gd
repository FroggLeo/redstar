extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0
const MAX_JUMPS = 1
var jump = 0
const CORPSE = preload("res://corpse.tscn")
var respawn_position = Vector2(0, 0)  # set a spawn point or checkpoint

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jump = 0
	
	# Handle jump.
	if Input.is_action_just_pressed("up") and jump <= MAX_JUMPS and not (velocity.y > 0 and jump == 0):
		velocity.y = JUMP_VELOCITY
		jump += 1
	
	if Input.is_action_just_pressed("die"):
		die()
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func die():
	# Spawn corpse at current position
	var corpse = CORPSE.instantiate()
	corpse.global_position = global_position
	get_parent().add_child(corpse)

	# Respawn player at checkpoint
	global_position = respawn_position
	velocity = Vector2.ZERO
