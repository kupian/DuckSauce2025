extends CharacterBody2D
@export var player : CharacterBody2D
const SPEED = 250.0
const JUMP_VELOCITY = -400.0
const SHOCK_ATTACK_DAMAGE = -40
var health = 100

func _physics_process(delta: float) -> void:
	
	var player_position = player.position
	var enemy_position = position
	var direction = player_position-enemy_position
	direction = direction.normalized()
	
	var distance = enemy_position.distance_to(player_position)
	if distance<10 && distance>2:
		var motion = direction*SPEED*delta
		move_and_collide(motion)
		$AnimatedSprite2D.play("walk")
	elif distance<2 && $AttackDelay.is_stopped():
		$AttackDelay.start()
		player.player_health-=20
		$AnimatedSprite2D.play("shock_attack")
		
		
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
