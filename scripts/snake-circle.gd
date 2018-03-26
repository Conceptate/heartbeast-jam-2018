#extends Node2D
#
#var direction = Vector2()
#var x_positions = [274, 415, 556, 697, 838, 979, 1120, 1261] # from 0 to 8
#var y_positions = [284, 425, 566, 707, 848, 989, 1130, 1271] # from 0 to 8
#
#const UP = Vector2(0, -1)
#const RIGHT = Vector2(1, 0)
#const DOWN = Vector2(0, 1)
#const LEFT = Vector2(-1, 0)
#
#var speed = 0
#const MAX_SPEED = 400
#
#func _ready():
#	set_fixed_process(true)
#
#func _fixed_process(delta):
#	var is_moving = Input.is_action_pressed("move_anydir")
#	
#	direction = Vector2()
#	if is_moving:
#		speed = MAX_SPEED
#		
#		if Input.is_action_pressed("move_up"):
#			direction += UP
#		elif Input.is_action_pressed("move_down"):
#			direction += DOWN
#		
#		if Input.is_action_pressed("move_left"):
#			direction += LEFT
#		elif Input.is_action_pressed("move_right"):
#			direction += RIGHT
#	else:
#		speed = 0
#	
#	var velocity = speed * direction.normalized() * delta
#	
#	move(velocity)

extends KinematicBody2D

var direction = Vector2()

const MAX_SPEED = 700

var speed = 0
var velocity = Vector2()

var target_pos = Vector2()
var target_direction = Vector2()
var is_moving = false

var type
var grid


func _ready():
	grid = get_parent()
	type = grid.PLAYER
	set_fixed_process(true)


func _fixed_process(delta):
	direction = Vector2()
	speed = 0

	if Input.is_action_pressed("move_up"):
		direction.y = -1
	elif Input.is_action_pressed("move_down"):
		direction.y = 1
	elif Input.is_action_pressed("move_left"):
		direction.x = -1
		find_node("goblin");
	elif Input.is_action_pressed("move_right"):
		direction.x = 1

	if not is_moving and direction != Vector2():
		target_direction = direction.normalized()
		if grid.is_cell_vacant(get_pos(), direction):
			target_pos = grid.update_child_pos(get_pos(), direction, type)
			is_moving = true
	elif is_moving:
		speed = MAX_SPEED
		velocity = speed * target_direction * delta

		var pos = get_pos()
		var distance_to_target = pos.distance_to(target_pos)
		var move_distance = velocity.length()

		if move_distance > distance_to_target:
			velocity = target_direction * distance_to_target
			is_moving = false

		move(velocity)
