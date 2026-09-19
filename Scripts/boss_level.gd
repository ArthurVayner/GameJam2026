extends Node2D

const throwing_object = preload("res://Scenes/ThrownObject.tscn")
@onready var throwing_obj_timer: Timer = $ThrowingObjTimer
@onready var boss: Sprite2D = $Boss
@onready var player: Player = $Player


var throwing_object_interval: int = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	throwing_obj_timer.start(throwing_object_interval)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func spawn_throwing_object() -> void:
	throwing_obj_timer.start(throwing_object_interval)


func _on_throwing_obj_timer_timeout() -> void:
	var y_offset = [15,20,25,30,35,40,45].pick_random()
	var object = throwing_object.instantiate()
	object.position = Vector2(boss.position.x, boss.position.y)
	object.look_at_player(player)
	add_child(object)
	print("object spawned")
	throwing_obj_timer.start(throwing_object_interval)
