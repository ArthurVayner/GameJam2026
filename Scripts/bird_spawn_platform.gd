@tool
extends "res://Scripts/Platform.gd"

const BIRD = preload("res://Scenes/bird.tscn")
const bird_scene  = preload("res://Scenes/bird.tscn")

@onready var detection_area: Area2D = $DetectionArea



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color = Color("D1EAEB")
	onStand = func (body:Player) -> void:
		bird_scene.can_instantiate()
		print("player is on me111")
	pass
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
