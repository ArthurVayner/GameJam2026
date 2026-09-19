extends Node

func _input(event):
	# OS.is_debug_build() ensures this code ONLY runs when playing from the editor.
	# When you eventually export your final game for players, this key does nothing.
	if OS.is_debug_build() and event is InputEventKey and event.pressed and event.keycode == KEY_R:
		get_tree().reload_current_scene()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
