extends Area2D

class_name Crown

@onready var boss_level_sfx: AudioStreamPlayer = $BossLevelSFX
@onready var win_sfx: AudioStreamPlayer = $WinSFX

var player_got_crown = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var player: Player = body
		boss_level_sfx.stop()
		win_sfx.play()
		player.game_win()
		player_got_crown = player.got_crown
