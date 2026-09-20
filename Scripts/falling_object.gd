extends Area2D

@onready var deletion_timer: Timer = $DeletionTimer


@export var speed = 0.8

var time_to_delete_self: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deletion_timer.start(time_to_delete_self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	self.position.y += speed


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.player_stunned()
		queue_free()
		


func _on_deletion_timer_timeout() -> void:
	queue_free()
