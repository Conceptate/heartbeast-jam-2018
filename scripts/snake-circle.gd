extends Node2D

var direction = Vector2()
var x_positions = [274, 415, 556, 697, 838, 979, 1120, 1261] # from 0 to 8
var y_positions = [284, 425, 566, 707, 848, 989, 1130, 1271] # from 0 to 8

const UP = Vector2(0, -1)
const RIGHT = Vector2(1, 0)
const DOWN = Vector2(0, 1)
const LEFT = Vector2(-1, 0)

var speed = 0
const MAX_SPEED = 400

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var is_moving = Input.is_action_pressed("move_anydir")
	
	direction = Vector2()
	if is_moving:
		speed = MAX_SPEED
		
		if Input.is_action_pressed("move_up"):
			direction += UP
		elif Input.is_action_pressed("move_down"):
			direction += DOWN
		
		if Input.is_action_pressed("move_left"):
			direction += LEFT
		elif Input.is_action_pressed("move_right"):
			direction += RIGHT
	else:
		speed = 0
	
	var velocity = speed * direction.normalized() * delta
	
	move(velocity)