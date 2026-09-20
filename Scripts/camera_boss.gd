extends Camera2D

@onready var player: Player = $".."
@onready var boss: Node2D = $"../../Boss"
@onready var instruction: Label = $"../../Instruction"



@onready var platform_to_delete1: StaticBody2D = $"../../Platforms to delete/Platform"
@onready var platform_to_delete2: StaticBody2D = $"../../Platforms to delete/Platform2"
@onready var remove_label_timer: Timer = $"../RemoveLabel"




@export var smooth_speed: float = 5.0

const maxLeft = -195
const maxRight = 140
const camera_y_offset = 10
const camera_x_offset = -2.5
const camera_acceleration = 0.0009

var camera_speed = 0
var is_cutscene: bool = true

func _ready() -> void:
	global_position.x = boss.global_position.x
	global_position.y = player.global_position.y

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
	if is_cutscene:
		global_position.x += camera_speed
		camera_speed += camera_acceleration
		if global_position.x >= player.position.x:
			is_cutscene = false
			platform_to_delete1.queue_free()
			platform_to_delete2.queue_free()
			remove_label_timer.start(2)
	else:
		var fallowPlayerPosition = calculatePosition(global_position.x, player.global_position.x, delta)
		global_position.x= calculatePosition(global_position.x + camera_x_offset, player.global_position.x,delta)
		global_position.y= calculatePosition(global_position.y, player.global_position.y - camera_y_offset, delta)
	
	if player_got_crown():
		var fallowPlayerPosition = calculatePosition(global_position.x, player.global_position.x, delta)
		global_position.x= calculatePosition(global_position.x, player.global_position.x,delta)
		global_position.y= calculatePosition(global_position.y, player.global_position.y, delta)
	
	
func _on_remove_label_timeout() -> void:
	if instruction:
		instruction.queue_free()

func player_got_crown() -> bool:
	if player.got_crown:
		return true
	return false
