@tool
extends "res://Scripts/Platform.gd"

const bird_scene  = preload("res://Scenes/bird.tscn")
@onready var spawning_cooldown: Timer = $"../spawningCooldown"
@onready var detection_area: Area2D = $DetectionArea

var player: Player
var playerStandOnCooldown: bool = false

func onStandFunc(body:Player) -> void:
	var parent_direction = get_parent().direction
	var parent_bird_distance_from_platform = get_parent().bird_distance_from_platform
	var new_bird = bird_scene.instantiate()
		
	add_child(new_bird)
	new_bird.spanBirdAwayFromPlayer(Vector2(body.global_position.x, global_position.y - 10), parent_bird_distance_from_platform * parent_direction, -5.0)
	new_bird.set_direction()
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color = Color("D1EAEB")
	
	super._ready()	
	onStand = func (body:Player) -> void:
		player = body
		if spawning_cooldown.is_stopped():
			call_deferred("onStandFunc", body)
			spawning_cooldown.start(1)
		else:
			playerStandOnCooldown = true
		print("player is on my nest")
	pass




func _on_spawning_cooldown_timeout() -> void:
	if playerStandOnCooldown:
		onStandFunc(player)
	playerStandOnCooldown = false
