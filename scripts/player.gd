extends CharacterBody2D


var SPEED = 130.0
var JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_normal: CollisionShape2D = $CollisionShapeNormal
@onready var collision_shape_small: CollisionShape2D = $CollisionShapeSmall


var gravity = ProjectSettings.get_setting('physics/2d/default_gravity')

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation_player.play('JumpSound')

	

	# gets the input direction: 1, 0,-1
	var direction := Input.get_axis("move_left", "move_right")
	
	# flips the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction <0:
		animated_sprite.flip_h = true
		
		
		# pnew_animationlay animations
	# animations for when you're crouching
	if Input.is_action_pressed("crouch"):
		animation_player.play('collisionSmall')
		JUMP_VELOCITY = -200.0
		SPEED = 60.0
		if is_on_floor():
			if direction == 0:
				animated_sprite.play('crouch')
			else:
				animated_sprite.play('crouch_walk')
		else:
			animated_sprite.play('crouch_jump')
	# animations for when you're not crouching
	else:
		animation_player.play('collisionBig')
		JUMP_VELOCITY = -300.0
		SPEED = 130.0
		if is_on_floor():
			if direction == 0:
				animated_sprite.play('idle')
			else:
				animated_sprite.play('run')
		else:
			animated_sprite.play('jump')
		

		
		
	
	# apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
