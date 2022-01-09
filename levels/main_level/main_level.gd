extends Node
class_name MainLevel

const GRID_SIZE = 4

# Tile ids
const AIR_TILE = 0
const GROUND_TILE = 1
const SPAWN_TILE = 2
const END_TILE = 3

# Player scene
export(PackedScene) var player = null

# Normal cell scene
export(PackedScene) var normal_cell = null
# Level end cell scene
export(PackedScene) var level_end_cell = null

var current_cells = []

func _ready():
	_generate_level()
	_spawn_player()

func _generate_level():
	if not normal_cell:
		push_error("No normal_cell scene set!")
		return

	if not level_end_cell:
		push_error("No level_end_cell scene set!")
		return

	var map = LevelTemplateGenerator.generate_level_template()

	for y in len(map):
		for x in len(map[y]):
			var tile = map[y][x]
			var new_cell

			if tile == AIR_TILE:
				continue
			elif tile == GROUND_TILE:
				new_cell = normal_cell.instance()
			elif tile == SPAWN_TILE:
				_reset_player_spawn(Vector2(x, y))
				new_cell = normal_cell.instance()
			elif tile == END_TILE:
				new_cell = level_end_cell.instance()

			if new_cell == null:
				continue

			$Map.add_child(new_cell)
			new_cell.transform.origin = Vector3(x * GRID_SIZE, 0, y * GRID_SIZE)
			current_cells.append(new_cell)

	for c_cell in current_cells:
		c_cell.update_faces(map, GRID_SIZE, AIR_TILE)
	
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
