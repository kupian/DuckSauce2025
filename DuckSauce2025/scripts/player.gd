extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const DASH_SPEED = 5000.0

var player_health = 100


func die():
	$AnimatedSprite2D.play("idle")
	CollisionShape2D.disabled=true   #causes player to fall through map
	
func take_damage(amount: int) -> void:
	player_health -=amount
	if player_health<=0:
		die()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		$AnimatedSprite2D.play("jump")
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		if is_on_floor():
			$AnimatedSprite2D.play("run")
		else:
			$AnimatedSprite2D.play("roll")
		if direction > 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
		velocity.x = direction * SPEED
		
		if Input.is_action_just_pressed("dash") and $Cooldown.is_stopped():		
			$AnimatedSprite2D.play("dash")
			velocity.x = direction * DASH_SPEED
			$Cooldown.start()
		
	else:
		if is_on_floor():
			$AnimatedSprite2D.play("idle")
		else:
			$AnimatedSprite2D.play("jump")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
