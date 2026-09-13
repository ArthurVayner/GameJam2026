@tool
extends "res://Scripts/Platform.gd"

const bird_scene  = preload("res://Scenes/bird.tscn")


@onready var detection_area: Area2D = $DetectionArea



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color = Color("D1EAEB")
	var parent_direction = get_parent().direction
	var new_bird = bird_scene.instantiate()
	
	onStand = func (body:Player) -> void:
		new_bird.spanBirdAwayFromPlayer(body.position, 100 * parent_direction, -38)
		add_child(new_bird)
		print("player is on my nest")
	pass
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
