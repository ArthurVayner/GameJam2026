extends Area2D

var direction: int = 1
var speed = 140.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("bird booste")
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	position.x += delta * speed * direction
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print()
		body.give_knockback(Vector2(350 * direction,-150))
		queue_free()
	pass # Replace with function body.
