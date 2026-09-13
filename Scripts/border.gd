extends Area2D


@export var speed = 0.05
@onready var speed_up_timer: Timer = $SpeedUpTimer


func _process(_delta: float) -> void:
	self.position.y -= speed
	
func _ready() -> void:
	speed_up_timer.start(2)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().reload_current_scene()  # make this indicate that the player lost


func _on_speed_up_timer_timeout() -> void:
	print("border boosted")
	speed += 0.05
	speed_up_timer.start(2)
