extends Spatial
class_name NormalCell

onready var front_wall = $FrontWall
onready var left_wall = $LeftWall
onready var right_wall = $RightWall
onready var back_wall = $BackWall

func update_faces(tilemap, grid_size):
	var current_pos = Vector2(translation.x / grid_size, translation.z / grid_size)

	if tilemap.has(current_pos + Vector2.RIGHT):
		right_wall.use_collision = false
		right_wall.hide()
	
	if tilemap.has(current_pos + Vector2.UP):
		front_wall.use_collision = false
		front_wall.hide()

	if tilemap.has(current_pos + Vector2.LEFT):
		left_wall.use_collision = false
		left_wall.hide()
	
	if tilemap.has(current_pos + Vector2.DOWN):
		back_wall.use_collision = false
		back_wall.hide()