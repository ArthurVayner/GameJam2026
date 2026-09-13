extends Camera2D

@onready var player: CharacterBody2D = $"../Player"

@export var smooth_speed: float = 5.0

const maxLeft = -195
const maxRight = 140
const camera_y_offset = 30

func die():
	print("11")
	get_tree().reload_current_scene()

func calculatePosition(curent:float,target:float,delta:float) ->float:
	var diff =(target-curent)
	# movement Speed is about smooth speed * delta but allowed between 1 and 0
	var movementSpeed= 1 - exp(-smooth_speed * delta)
	return curent + diff * movementSpeed
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var fallowPlayerPosition = calculatePosition(global_position.x, player.global_position.x, delta)
	#clamp(value: Variant, min: Variant, max: Variant)
	global_position.x= clamp(fallowPlayerPosition, maxLeft, maxRight)
	global_position.y= calculatePosition(global_position.y, player.global_position.y - camera_y_offset, delta)
	
	
	
	
	
