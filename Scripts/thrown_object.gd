extends Area2D

@export var speed = 0.8


var throwing_object_offset: int = 200
var throwing_object_interval: int = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	self.position.x += speed





func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.give_knockback(Vector2(350,-150))
		queue_free()
