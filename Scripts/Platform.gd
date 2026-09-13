@tool
extends StaticBody2D

@export var color: Color = Color("00fa9a"):
	set(value):
		color = value

@export var width: float =100.0:
	set(value):
		width=value
		if is_node_ready():
			setSize()
#		
@export var height: float = 20.0:
	set(value):
		height=value
		if is_node_ready():
			setSize()

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var detection_area_shape: CollisionShape2D = $DetectionArea/CollisionShape2D

var onStand = func (body:Player) -> void:
	print("player is on me")
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setSize()
	
	
func setSize()-> void:
	if collision_shape_2d.shape:
		collision_shape_2d.shape = collision_shape_2d.shape.duplicate()

	collision_shape_2d.shape.size = Vector2(width, height)
	
	if detection_area_shape and detection_area_shape.shape:
		detection_area_shape.shape= detection_area_shape.shape.duplicate()
		detection_area_shape.shape.size = Vector2(width - 1, 2 )
		detection_area_shape.position = Vector2(0, -height/2 )
		


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Player:
		onStand.call(body)
