extends Area2D

@export var speed = 0.8

@onready var player: Player = $Player


var throwing_object_offset: int = 200
var throwing_object_interval: int = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	global_position.x += speed



func look_at_player(player: Player) -> void:
	look_at(player.global_position)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.give_knockback(Vector2(350,-150))
		queue_free()
