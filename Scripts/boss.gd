extends Node2D

class_name Boss

const throwing_object = preload("res://Scenes/ThrownObject.tscn")

@onready var boss_throw_sfx: AudioStreamPlayer2D = $BossThrowSFX

@onready var throw_animation: AnimatedSprite2D = $AnimatedSprite2D



@onready var throwing_obj_timer: Timer = $ThrowingObjTimer
@onready var throwing_obj_timer_2: Timer = $ThrowingObjTimer2

@onready var crown: Area2D = $Crown

var boss_can_throw = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	throwing_obj_timer.start(1)
	throwing_obj_timer_2.start(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if crown.player_got_crown:
		boss_can_throw = false


func object_spawn() -> void:
	var offset = [0,15,30,45].pick_random()
	var object = throwing_object.instantiate()
	object.global_position = Vector2(global_position.x, global_position.y - offset)
	get_parent().add_child(object)
	throw_animation.play("Throw")
	boss_throw_sfx.play()



func _on_throwing_obj_timer_timeout() -> void:
	if boss_can_throw:
		object_spawn()
		var throwing_object_interval: float = [0.8,1].pick_random()
		throwing_obj_timer.start(throwing_object_interval)
	

func _on_throwing_obj_timer_2_timeout() -> void:
	if boss_can_throw:
		object_spawn()
		var throwing_object_interval: float = [0.7,0.9].pick_random()
		throwing_obj_timer_2.start(throwing_object_interval)
	
