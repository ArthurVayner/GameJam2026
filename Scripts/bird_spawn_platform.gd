@tool
extends "res://Scripts/Platform.gd"

const bird_scene  = preload("res://Scenes/bird.tscn")


@onready var detection_area: Area2D = $DetectionArea



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color = Color("D1EAEB")
	var parent_direction = get_parent().direction
	var parent_bird_distance_from_platform = get_parent().bird_distance_from_platform
	
	super._ready()	
	onStand = func (body:Player) -> void:
		var new_bird = bird_scene.instantiate()
			
		new_bird.spanBirdAwayFromPlayer(body.global_position, parent_bird_distance_from_platform * parent_direction, -5.0)
		add_child(new_bird)
		print("player is on my nest")
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
