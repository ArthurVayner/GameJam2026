extends Area2D

@export var speed = 75



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position.x += speed * delta
	



#func find_player() -> Vector2:
	#var player: Player = get_parent().find_child("Player")
	#return player.global_position


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.give_knockback(Vector2(500,-150))
		queue_free()
