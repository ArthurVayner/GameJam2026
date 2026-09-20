extends Area2D

@onready var flapping_sound: AudioStreamPlayer2D = $FlappingSound
@onready var flapping_sound_timer: Timer = $FlappingSoundTimer
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D


var direction: int = 1
var speed = 140.0

func set_direction() -> void:
	sprite_2d.flip_h = direction == 1

func spanBirdAwayFromPlayer(position: Vector2, distance: float, yPositionOffset: float)-> void:
	direction = -sign(distance)
	var yPosition = position.y + yPositionOffset
	var xPosition = position.x + distance
	global_position = Vector2(xPosition, yPosition)
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_direction()
	flapping_sound_timer.start(0.5)

func _physics_process(delta: float) -> void:
	position.x += delta * speed * direction
	if abs(position.x)>1000:
		print("queue_free")
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.give_knockback(Vector2(250 * direction, -100))
		queue_free()

func _on_falpping_sound_timer_timeout() -> void:
	flapping_sound.play()
	flapping_sound_timer.start(0.5)
