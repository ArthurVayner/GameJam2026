extends Area2D

@onready var flapping_sound: AudioStreamPlayer2D = $FlappingSound
@onready var flapping_sound_timer: Timer = $FlappingSoundTimer

var direction: int = 1
var speed = 140.0

func spanBirdAwayFromPlayer(player_position: Vector2, distance: float, yPositionOffset: float)-> void:
	direction = -sign(distance)
	var yPosition = player_position.y + yPositionOffset
	var xPosition = player_position.x + distance
	global_position = Vector2(xPosition, yPosition)
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	flapping_sound_timer.start(0.5)
	print("bird booste")
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	position.x += delta * speed * direction
	if abs(position.x)>1000:
		print("queue_free")
		queue_free()
		
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.give_knockback(Vector2(350 * direction, -100))
		queue_free()
	pass # Replace with function body.
	


func _on_falpping_sound_timer_timeout() -> void:
	flapping_sound.play()
	flapping_sound_timer.start(0.5)
