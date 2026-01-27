extends CharacterBody2D


const SPEED = 125.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var double_jump = 1
var double_jump_count = 1
var jump_release_force = -40
var jump_force = -160

@onready var animated_sprite = $Violet

# Main Player Controls	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("Jump")


	# Get the input direction: -1,0,1
	var direction = Input.get_axis("move_left", "move_right")
	 
		# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	#apply movement
	if direction: 
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		# Player is in the air - Check vertical direction
		if velocity.y < 0:
			animated_sprite.play("Jump")
		else:
			animated_sprite.play("death")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
