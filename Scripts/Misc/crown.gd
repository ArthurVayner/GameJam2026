extends Sprite2D

@onready var player: Player = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.position.y = player.position.y
