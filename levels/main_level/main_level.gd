extends Node

const GRID_SIZE = 4

# Player scene
export(PackedScene) var player = null

# Normal cell scene
export(PackedScene) var normal_cell = null
# Level end cell scene
export(PackedScene) var level_end_cell = null
# Map template
export(PackedScene) var map_template = null

var current_cells = []

func _ready():
	_generate_level()
	_spawn_player()

func _generate_level():
	if not map_template:
		push_error("No map template set!")
		return

	if not normal_cell:
		push_error("No normal_cell scene set!")
		return

	if not level_end_cell:
		push_error("No level_end_cell scene set!")
		return

	print("Current stage: %s" % GameManager.get_current_stage())
	print("Current stage progress: %s" % GameManager.get_current_stage_progress())
	print("Current progress: %s" % GameManager.get_overall_progress())
	
	var map = map_template.instance()
	var tilemap = map.get_tilemap()
	var used_tiles = tilemap.get_used_cells()
	var player_spawn_tile = tilemap.get_used_cells_by_id(0)[0]
	var level_end_tile = tilemap.get_used_cells_by_id(2)[0]
	tilemap.free()

	_reset_player_spawn(player_spawn_tile)

	for tile in used_tiles:
		var new_cell

		if tile == level_end_tile:
			new_cell = level_end_cell.instance()
		else:
			new_cell = normal_cell.instance()

		$Map.add_child(new_cell)
		new_cell.transform.origin = Vector3(tile.x * GRID_SIZE, 0, tile.y * GRID_SIZE)
		current_cells.append(new_cell)

	for c_cell in current_cells:
		c_cell.update_faces(used_tiles, GRID_SIZE)
	
func _spawn_player():
	if player == null:
		push_error("No Player scene set!!")
		return

	var player_instance = player.instance()
	player_instance.transform.origin = $PlayerSpawn.transform.origin
	player_instance.rotation_degrees = $PlayerSpawn.rotation_degrees

	add_child(player_instance)

	WeaponManager.reset_player_weapon()
	
func _reset_player_spawn(tile):
	$PlayerSpawn.transform.origin = Vector3(tile.x * GRID_SIZE, 0.1, tile.y * GRID_SIZE)
