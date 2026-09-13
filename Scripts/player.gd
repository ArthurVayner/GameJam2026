class_name Player
extends CharacterBody2D

@onready var stun_timer: Timer = $StunTimer
@onready var stun_effect: Sprite2D = $StunEffect

const WALK_SPEED = 100.0
const JUMP_VELOCITY = -300.0
const ACCELERATION = 2000.0
const FRICTION = 400.0

var can_move: bool = true

func give_knockback(value:Vector2) -> void:
	print(1)
	velocity = value


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and can_move:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction and can_move:
		velocity.x = move_toward(velocity.x, direction * WALK_SPEED, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		
	move_and_slide()

	
	
	
func player_stunned():
	can_move = false
	stun_effect.visible = true
	stun_timer.start(1)


func _on_stun_timer_timeout() -> void:
	can_move = true
	stun_effect.visible = false
