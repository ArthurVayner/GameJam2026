class_name Player
extends CharacterBody2D

@onready var stun_timer: Timer = $StunTimer
@onready var moving_sound_timer: Timer = $MovingSoundTimer
@onready var jump_buffer_timer: Timer = $JumpBufferTimer
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var stun_effect: Sprite2D = $StunEffect

@onready var jump_sfx: AudioStreamPlayer2D = $JumpSFX
@onready var walk_sfx: AudioStreamPlayer2D = $WalkSFX
@onready var hit_sfx: AudioStreamPlayer2D = $HitSFX

@export var WALK_SPEED = 100.0
@export var JUMP_VELOCITY = -320.0
const ACCELERATION = 2500.0
const FRICTION = 8000.0
const AIR_FRICTION = 400.0
const heavy_gravity_multiplier = 2.0
const terminal_velocity = 600.0
func get_overspeeding_acceleration(direction: float) -> float:
	return 1000.0 if sign(velocity.x) == -direction else 500.0 if sign(velocity.x) == direction else 700.0


var can_move: bool = true
var is_moving: bool = false

func _ready() -> void:
	moving_sound_timer.start(0.1)

func _physics_process(delta: float) -> void:
	if is_on_floor():
		coyote_timer.start(0.1)
	
	# Handle jump.
	var can_jump = (is_on_floor() or !coyote_timer.is_stopped()) and can_move
	if can_jump:
		if Input.is_action_just_pressed("jump") or !jump_buffer_timer.is_stopped():
			velocity.y = JUMP_VELOCITY
			jump_sfx.play()
			jump_buffer_timer.stop()
			coyote_timer.stop()
	elif Input.is_action_just_pressed("jump"):
			jump_buffer_timer.start(0.1)

		
	var gravityMultiplier := heavy_gravity_multiplier if velocity.y < 0 and not Input.is_action_pressed("jump") else 1.0
	if not is_on_floor():
		velocity += get_gravity() * delta * gravityMultiplier
		velocity.y = min(velocity.y, terminal_velocity)

	# Get the input direction. If we can't move, force it to 0.
	var direction := Input.get_axis("go_left", "go_right") if can_move else 0.0
	is_moving= bool(direction)
	var is_overspeeding = abs(velocity.x) > WALK_SPEED

	if is_overspeeding:
		var overspeedingAcceleration := get_overspeeding_acceleration(direction)
		velocity.x = move_toward(velocity.x, direction * WALK_SPEED, overspeedingAcceleration * delta)
	elif direction != 0:
		var is_turning_around = sign(direction) != sign(velocity.x) and velocity.x != 0
		var current_accel = ACCELERATION * 2.0 if is_turning_around else ACCELERATION
		
		velocity.x = move_toward(velocity.x, direction * WALK_SPEED, current_accel * delta)
			
	else:
		var friction = FRICTION if is_on_floor() and velocity.y >= 0 else AIR_FRICTION
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		
	move_and_slide()


func player_stunned():
	hit_sfx.play()
	can_move = false
	stun_effect.visible = true
	stun_timer.start(1)


func _on_stun_timer_timeout() -> void:
	can_move = true
	stun_effect.visible = false


func _on_moving_sound_timer_timeout() -> void:
	if is_moving and is_on_floor():
		walk_sfx.play()
	moving_sound_timer.start(0.296)
	
func give_knockback(value:Vector2) -> void:
	hit_sfx.play()
	velocity += value
	velocity.y = max(velocity.y, -250)
	print('velocity.y give_knockback',velocity.y)
