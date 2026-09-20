extends Area2D


@onready var player_ded: AudioStreamPlayer2D = $PlayerDed
@onready var restart_timer: Timer = $RestartTimer


@export var speed: float = 0.05
@export var max_speed = speed * 5
@export var speedup: float = 0.05
@export var speedup_interval: int = 2
@export var restart_interval: int = 2
@onready var speed_up_timer: Timer = $SpeedUpTimer





func _process(_delta: float) -> void:
	self.position.y -= speed
	
func _ready() -> void:
	speed_up_timer.start(speedup_interval)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var player = body
		player.visible = false
		player.can_move = false
		border_stop()
		player_ded.play()
		restart_timer.start(restart_interval)


func border_stop() -> void:
	speed = 0
	speedup = 0

func _on_speed_up_timer_timeout() -> void:
	if speed < max_speed:
		speed += speedup
		speed_up_timer.start(speedup_interval)


func _on_restart_timer_timeout() -> void:
	get_tree().reload_current_scene()  # make this indicate that the player lost
