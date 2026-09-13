class_name Player
extends CharacterBody2D

@onready var stun_timer: Timer = $StunTimer
@onready var moving_sound_timer: Timer = $MovingSoundTimer


@onready var stun_effect: Sprite2D = $StunEffect

@onready var jump_sfx: AudioStreamPlayer2D = $JumpSFX
@onready var walk_sfx: AudioStreamPlayer2D = $WalkSFX
@onready var hit_sfx: AudioStreamPlayer2D = $HitSFX



@export var WALK_SPEED = 100.0
@export var JUMP_VELOCITY = -300.0
const ACCELERATION = 1500.0
const FRICTION = 400.0

var can_move: bool = true
var is_moving: bool = true


func _ready() -> void:
	
	moving_sound_timer.start(0.1)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and can_move:
		velocity.y = JUMP_VELOCITY
		jump_sfx.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	var direction := Input.get_axis("go_left", "go_right")
	if direction and can_move:
		velocity.x = move_toward(velocity.x, direction * WALK_SPEED, ACCELERATION * delta)
		is_moving = true
		#print("moving")
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		is_moving = false
		#print("not moving")
		
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
	if is_moving:
		walk_sfx.play()
	moving_sound_timer.start(0.296)
	
func give_knockback(value:Vector2) -> void:
	hit_sfx.play()
	print(1)
	velocity = value
