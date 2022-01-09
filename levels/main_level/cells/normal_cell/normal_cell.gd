extends Spatial
class_name NormalCell

onready var front_wall = $FrontWall
onready var left_wall = $LeftWall
onready var right_wall = $RightWall
onready var back_wall = $BackWall

func update_faces(tilemap, grid_size, void_tile):
	var current_pos = Vector2(translation.x / grid_size, translation.z / grid_size)

	if _point_exists(tilemap, current_pos + Vector2.RIGHT, void_tile):
		right_wall.use_collision = false
		right_wall.hide()
	
	if _point_exists(tilemap, current_pos + Vector2.UP, void_tile):
		front_wall.use_collision = false
		front_wall.hide()

	if _point_exists(tilemap, current_pos + Vector2.LEFT, void_tile):
		left_wall.use_collision = false
		left_wall.hide()
	
	if _point_exists(tilemap, current_pos + Vector2.DOWN, void_tile):
		back_wall.use_collision = false
		back_wall.hide()

func _in_range(x, low, high):
	return x >= low and x < high

func _point_exists(map, point, void_tile):
	if not _in_range(point.x, 0, len(map[0])) or not _in_range(point.y, 0, len(map)):
		return true
	
	return map[point.y][point.x] != void_tile
