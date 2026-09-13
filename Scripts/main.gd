extends Node2D

const falling_object = preload("res://Scenes/FallingObject.tscn")
@onready var falling_obj_timer: Timer = $FallingObjTimer
@onready var player: Player = $Player


var falling_object_offset: int = 200
var falling_object_interval: int = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	falling_obj_timer.start(falling_object_interval)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_falling_obj_timer_timeout() -> void:
	var object = falling_object.instantiate()
	object.position = Vector2(player.position.x, player.position.y - falling_object_offset)
	add_child(object)
	print("object spawned")
	falling_obj_timer.start(falling_object_interval)
