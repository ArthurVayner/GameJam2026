extends Node2D

@onready var show_label_timer: Timer = $ShowLabelTimer
@onready var restart_game: RichTextLabel = $RestartGame


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	restart_game.visible = false
	show_label_timer.start(2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("start"):
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")


func _on_show_label_timer_timeout() -> void:
	restart_game.visible = true
