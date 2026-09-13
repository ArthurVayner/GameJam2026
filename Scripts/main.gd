extends Node2D

const falling_object = preload("res://Scenes/FallingObject.tscn")
const bird_scene  = preload("res://Scenes/bird.tscn")
@onready var falling_obj_timer: Timer = $FallingObjTimer
@onready var bird_timer: Timer = $BirdTimer
@onready var player: Player = $Player



var falling_object_offset: int = 200
var falling_object_interval: int = 4

func reset_bird_timer() -> void:
	bird_timer.start(randf_range(2,7))
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_falling_object()
	reset_bird_timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func spawn_falling_object() -> void:
	falling_obj_timer.start(falling_object_interval)

func _on_falling_obj_timer_timeout() -> void:
	var object = falling_object.instantiate()
	object.position = Vector2(player.position.x, player.position.y - falling_object_offset)
	add_child(object)
	#print("object spawned")
	falling_obj_timer.start(falling_object_interval)


func spawneBird() -> void:
	var new_bird = bird_scene .instantiate()
	var direction = [1,-1].pick_random()
	new_bird.direction= direction
	
	var yPosition = min(player.position.y + randf_range(-40, 40), 55)
	var xPosition = player.position.x - direction * 100
	new_bird.position = Vector2(xPosition, yPosition)
	add_child(new_bird)

func _on_bird_timer_timeout() -> void:
	var birdsAmount : int= [1,1,1,2,2,3].pick_random()
	for i in range(0, birdsAmount): 
		spawneBird()
	reset_bird_timer()
	
	
	
