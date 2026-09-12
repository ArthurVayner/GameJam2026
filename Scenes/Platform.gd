@tool
extends StaticBody2D

@export var width: float =100.0:
	set(value):
		width=value
		setSize()
		
@export var height: float = 20.0:
	set(value):
		height=value
		setSize()

@onready var polygon_2d: Polygon2D = $Polygon2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setSize()
	
	
func setSize()-> void:
	if not polygon_2d or not collision_shape_2d:
		return
	polygon_2d.polygon = PackedVector2Array(
		[
		Vector2(-width / 2,-height/2),
		Vector2(width / 2,-height/2),
			Vector2(width / 2, height/2),
			Vector2(-width / 2, height/2)]
		)

	if collision_shape_2d.shape:
		collision_shape_2d.shape = collision_shape_2d.shape.duplicate()

	collision_shape_2d.shape.size = Vector2(width, height)
		
