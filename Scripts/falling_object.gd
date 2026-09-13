extends Area2D

@export var speed = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position.y += speed


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().reload_current_scene()
