extends Node2D

@onready var main_theme: AudioStreamPlayer = $MainTheme
@onready var boss_transition_sfx: AudioStreamPlayer = $BossTransition


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_transition_body_entered(body: Node2D) -> void:
	if body is Player:
		var player = body
		main_theme.stop()
		boss_transition_sfx.play()
		player.transition_to_boss()
		
		
		
