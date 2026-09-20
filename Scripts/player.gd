class_name Player
extends CharacterBody2D

@onready var stun_timer: Timer = $StunTimer
@onready var jump_buffer_timer: Timer = $JumpBufferTimer
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var win_transition: Timer = $WinTransition
@onready var boss_transition: Timer = $BossTransition



@onready var player_icon: AnimatedSprite2D = $Icon


@onready var jump_sfx: AudioStreamPlayer2D = $JumpSFX
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
var got_crown: bool = false
var player_lose: bool = false
var transitioning: bool = false

func _physics_process(delta: float) -> void:
	if transitioning:
		velocity.x = -28
		player_gravity(delta)
		move_and_slide()
		return
	if got_crown or player_lose:
		return
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

	player_gravity(delta)

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
	
	if can_move and is_on_floor():
		if abs(velocity.x) > 1.0:
			player_icon.play("Walk")
			player_icon.scale.x = -sign(velocity.x)
		else:
			player_icon.play("Idle")
	if can_move and not is_on_floor():
			player_icon.play("Jump")

	
	move_and_slide()

func player_gravity(delta) -> void:
	var gravityMultiplier := 1.0
	if velocity.y < 0 and not Input.is_action_pressed("jump"):
		gravityMultiplier = heavy_gravity_multiplier
	elif abs(velocity.y) < 20.0 and Input.is_action_pressed("jump"):
		gravityMultiplier = 0.66

	if not is_on_floor():
		velocity += get_gravity() * delta * gravityMultiplier
		velocity.y = min(velocity.y, terminal_velocity)

func player_stunned():
	hit_sfx.play()
	can_move = false
	player_icon.stop()
	player_icon.play("Stunned")
	stun_timer.start(1)


func _on_stun_timer_timeout() -> void:
	can_move = true



	
func give_knockback(value:Vector2) -> void:
	hit_sfx.play()
	velocity += value
	velocity.y = max(velocity.y, -250)
	


func transition_to_boss() -> void:
	transitioning = true
	boss_transition.start(2.5)
	player_icon.play("Walk")
	can_move = false


func game_win():
	got_crown = true  #transition to winning screen
	win_transition.start(3)


func _on_win_transition_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/winning_scene.tscn")


func _on_boss_transition_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/BossLevel.tscn")
