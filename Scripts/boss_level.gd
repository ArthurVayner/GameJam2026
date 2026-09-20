extends Node2D

const throwing_object = preload("res://Scenes/ThrownObject.tscn")

@onready var boss_throw_sfx: AudioStreamPlayer2D = $Boss/Boss_Throw_SFX



@onready var throwing_obj_timer: Timer = $ThrowingObjTimer
@onready var throwing_obj_timer_2: Timer = $ThrowingObjTimer2
@onready var boss: Node2D = $Boss
@onready var player: Player = $Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	throwing_obj_timer.start(1)
	throwing_obj_timer_2.start(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func object_spawn() -> void:
	var offset = [0,15,30,45].pick_random()
	var object = throwing_object.instantiate()
	object.global_position = Vector2(boss.global_position.x, boss.global_position.y - offset)
	add_child(object)
	boss_throw_sfx.play()



func _on_throwing_obj_timer_timeout() -> void:
	object_spawn()
	var throwing_object_interval: float = [0.8,1].pick_random()
	throwing_obj_timer.start(throwing_object_interval)
	

func _on_throwing_obj_timer_2_timeout() -> void:
	object_spawn()
	var throwing_object_interval: float = [0.9,1.1].pick_random()
	throwing_obj_timer_2.start(throwing_object_interval)
