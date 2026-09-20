extends Node2D

@onready var theme: AudioStreamPlayer = $Theme
@onready var quit_sound: AudioStreamPlayer = $QuitSound
@onready var quit_timer: Timer = $QuitTimer
@onready var player_idle: Sprite2D = $PlayerIdle


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("start"):
		get_tree().change_scene_to_file("res://Scenes/Main.tscn")
	if Input.is_action_just_pressed("exit"):
		print("wtf")
		player_idle.texture = preload("res://Assets/Player Animation/Player_stunned.png")
		theme.stop()
		quit_sound.play()
		quit_timer.start(2)



func _on_quit_timer_timeout() -> void:
	get_tree().quit()
