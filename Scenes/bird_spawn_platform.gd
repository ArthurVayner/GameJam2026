extends Node2D

@export_enum("Right:1", "Left:-1") var direction: int = 1
@export var bird_distance_from_platform: float = 100.0
@export var width: float = 24.0
enum PLATFROM_TEXTURE {ONE, ONE_ROTATED, TWO, TWO_ROTATED, THREE, THREE_ROTATED, FOUR, FOUR_ROTATED, INVISIBLE}
@export var platform_texture: PLATFROM_TEXTURE

@onready var platform: StaticBody2D = $Platform


func _ready() -> void:
	platform.platform_texture = platform_texture
	platform.set_texture()
	platform.width = width
