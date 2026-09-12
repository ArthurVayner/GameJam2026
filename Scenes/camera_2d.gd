extends Camera2D

@onready var player: CharacterBody2D = $"../Player"

@export var smooth_speed: float = 5.0

var maxCemaraYPostion=0

func calculatePosition(curent:float,target:float,delta:float) ->float:
	var diff =(target-curent)
	var movementSpeed= 1 - exp(-smooth_speed * delta)
	return curent + diff * movementSpeed
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x= calculatePosition(global_position.x, player.global_position.x, delta)
	var a= calculatePosition(global_position.y, player.global_position.y, delta)
	global_position.y= min(a,maxCemaraYPostion)
	maxCemaraYPostion = global_position.y
	
	
	
	
	
