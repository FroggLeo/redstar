extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0
const MAX_JUMPS = 1
var jump = 0

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
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
