extends TileMap

enum ENTITY_TYPES {PLAYER, OBSTACLE, COLLECTIBLE}

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2
var grid_size = Vector2(8, 8)

var grid = []
onready var Obstacle = preload("res://scenes/obstacle.tscn")
onready var Goblin = preload("res://scenes/goblin.tscn")
onready var Player = preload("res://scenes/snake_circle.tscn")
onready var Fruit_1 = preload("res://scenes/Fruit_1.tscn")

func _ready():
	randomize()
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)

	# Obstacles
	var obstacle_positions = []
	for x in range(9):
		var obstacle_placed = false
		while not obstacle_placed:
			var grid_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
			if not grid[grid_pos.x][grid_pos.y]:
				if not grid_pos in obstacle_positions:
					obstacle_positions.append(grid_pos)
					obstacle_placed = true

	# Enemies
	var goblin_positions = []
	for x in range(2):
		var goblin_placed = false
		while not goblin_placed:
			var grid_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
			if not grid[grid_pos.x][grid_pos.y]:
				if not grid_pos in goblin_positions and not grid_pos in obstacle_positions:
					goblin_positions.append(grid_pos)
					goblin_placed = true

		# Fruit
	var fruit_positions = []
	for x in range(2):
		var fruit_placed = false
		while not fruit_placed:
			var grid_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
			if not grid[grid_pos.x][grid_pos.y]:
				if not grid_pos in fruit_positions:
					fruit_positions.append(grid_pos)
					fruit_placed = true

	for object_place_pos in obstacle_positions:
		var new_obstacle = Obstacle.instance()
		new_obstacle.set_pos(map_to_world(object_place_pos) + half_tile_size)
		grid[object_place_pos.x][object_place_pos.y] = new_obstacle.get_name()
		add_child(new_obstacle)
	
	for goblin_place_pos in goblin_positions:
		var new_goblin = Goblin.instance()
		new_goblin.set_pos(map_to_world(goblin_place_pos) + half_tile_size)
		grid[goblin_place_pos.x][goblin_place_pos.y] = new_goblin.get_name()
		add_child(new_goblin)
	
	for fruit_place_pos in fruit_positions:
		var new_fruit = Fruit_1.instance()
		new_fruit.set_pos(map_to_world(fruit_place_pos) + half_tile_size)
		grid[fruit_place_pos.x][fruit_place_pos.y] = new_fruit.get_name()
		add_child(new_fruit)

	# Player
	var new_player = Player.instance()
	new_player.set_pos(map_to_world(Vector2(4,4)) + half_tile_size)
	add_child(new_player)

func get_cell_content(object_place_pos=Vector2()):
	return grid[object_place_pos.x][object_place_pos.y]


func is_cell_vacant(object_place_pos=Vector2(), direction=Vector2()):
	var grid_pos = world_to_map(object_place_pos) + direction

	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
			return true if grid[grid_pos.x][grid_pos.y] == null else false
	return false


func update_child_pos(new_pos, direction, type):
	# Remove node from current cell, add it to the new cell, returns the new target move_to position
	var grid_pos = world_to_map(new_pos)
	print(self)
	print(grid_pos)
	grid[grid_pos.x][grid_pos.y] = null
	
	var new_grid_pos = grid_pos + direction
	grid[new_grid_pos.x][new_grid_pos.y] = type
	
	var target_pos = map_to_world(new_grid_pos) + half_tile_size
	return target_pos
