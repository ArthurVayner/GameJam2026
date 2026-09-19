@tool
extends StaticBody2D


enum PLATFROM_TEXTURE {ONE, ONE_ROTATED, TWO, TWO_ROTATED, THREE, THREE_ROTATED, FOUR, FOUR_ROTATED,BOSS, INVISIBLE}
@export var platform_texture: PLATFROM_TEXTURE


@export var color: Color = Color("00fa9a"):
	set(value):
		color = value

@export var width: float =24.0:
	set(value):
		width=value
		if is_node_ready():
			setSize()
#		
@export var height: float = 8.0:
	set(value):
		height=value
		if is_node_ready():
			setSize()

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var detection_area_shape: CollisionShape2D = $DetectionArea/CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D


var onStand = func (body:Player) -> void:
	print("player is on me")
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setSize()
	set_texture()
	
	
func setSize()-> void:
	if collision_shape_2d.shape:
		collision_shape_2d.shape = collision_shape_2d.shape.duplicate()

	collision_shape_2d.shape.size = Vector2(width, height)
	
	if detection_area_shape and detection_area_shape.shape:
		detection_area_shape.shape= detection_area_shape.shape.duplicate()
		detection_area_shape.shape.size = Vector2(width - 1, 2 )
		detection_area_shape.position = Vector2(0, -height/2 )
		

func set_texture() -> void:
	match platform_texture:
		PLATFROM_TEXTURE.ONE:
			sprite_2d.texture = load("res://Assets/images/Platform.png")
		PLATFROM_TEXTURE.ONE_ROTATED:
			sprite_2d.texture = load("res://Assets/images/Platform.png")
			scale.x = -1
		PLATFROM_TEXTURE.TWO:
			sprite_2d.texture = load("res://Assets/images/Platform2.png")
		PLATFROM_TEXTURE.TWO_ROTATED:
			sprite_2d.texture = load("res://Assets/images/Platform2.png")
			scale.x = -1
		PLATFROM_TEXTURE.THREE:
			sprite_2d.texture = load("res://Assets/images/Platform3.png")
		PLATFROM_TEXTURE.THREE_ROTATED:
			sprite_2d.texture = load("res://Assets/images/Platform3.png")
			scale.x = -1
		PLATFROM_TEXTURE.FOUR:
			sprite_2d.texture = load("res://Assets/images/Platform4.png")
		PLATFROM_TEXTURE.FOUR_ROTATED:
			sprite_2d.texture = load("res://Assets/images/Platform4.png")
			scale.x = -1
		PLATFROM_TEXTURE.BOSS:
			sprite_2d.texture = load("res://Assets/images/Boss_Platfrom.png")
		9:
			sprite_2d.texture = null


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Player:
		onStand.call(body)
