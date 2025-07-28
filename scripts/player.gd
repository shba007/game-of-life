extends CharacterBody2D

@onready var game_manager: Node = %GameManager

const INITIAL_SPEED = 130.0
const SPEED_FACTOR = 10.0
const MIN_SPEED := 75.0 

const INITIAL_JUMP_VELOCITY = -350.0
const JUMP_VELOCITY_FACTOR = -10.0
const MIN_JUMP_VELOCITY := -200.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var JUMP_VELOCITY = min(INITIAL_JUMP_VELOCITY - game_manager.coins_collected * JUMP_VELOCITY_FACTOR, MIN_JUMP_VELOCITY)
	var SPEED = max(INITIAL_SPEED - game_manager.coins_collected * SPEED_FACTOR, MIN_SPEED)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle suicide.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	# Play animations
	if not is_on_floor():
		animated_sprite.play('jump')
	elif direction == 0:
		animated_sprite.play('idle')
	else:
		animated_sprite.play('run')
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
