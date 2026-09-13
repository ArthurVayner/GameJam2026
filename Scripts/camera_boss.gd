extends Camera2D

@onready var player: CharacterBody2D = $"../Player"
@onready var crown: Sprite2D = $"../Crown"


@export var smooth_speed: float = 5.0

const maxLeft = -195
const maxRight = 140
const camera_y_offset = 35
const camera_x_offset = -2.5

func _ready() -> void:
	self.global_position = crown.global_position

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
	if global_position.x < player.position.x - camera_x_offset:
		global_position.x += 3
	else:
		var fallowPlayerPosition = calculatePosition(global_position.x, player.global_position.x, delta)
		#clamp(value: Variant, min: Variant, max: Variant)
		global_position.x= calculatePosition(global_position.x + camera_x_offset, player.global_position.x,delta)
		global_position.y= calculatePosition(global_position.y, player.global_position.y - camera_y_offset, delta)
	
	
	
	
	
