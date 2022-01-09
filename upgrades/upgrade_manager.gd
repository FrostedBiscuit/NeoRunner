extends Node

# Base upgrade dictionary
const PLAYER_UPGRADE_STATS_BASE = {
	UpgradeTypes.Type.HEALTH: 0,
	UpgradeTypes.Type.AMMO: 0,
	UpgradeTypes.Type.MOVEMENT_SPEED: 0,
	UpgradeTypes.Type.RELOAD_SPEED: 0,
	UpgradeTypes.Type.DAMAGE: 0
}
const UPGRADES_FOLDER = "res://upgrades/resources/"

# Player reference
var player = null
var player_upgrade_handler = null

# List of  all upgrades
var upgrades = []
# Current upgrades and upgrade stats for player
var player_upgrades = []
var player_upgrade_stats = PLAYER_UPGRADE_STATS_BASE

func _ready():
	_load_upgrades_from_dir(UPGRADES_FOLDER)
	pass

func get_3_random_upgrades():
	var result = []

	# Calculate weights for each upgrade based on
	# the upgrade's required progression and the player's
	# current progress
	var pr_scale = 10
	var progress = GameManager.get_overall_progress() * pr_scale
	var upgrade_weights = []
	
	for u in upgrades:
		# Compute upgrade's weight
		var y = 1 / exp(pow((u.required_progress * pr_scale) - progress, 2))
		print("%s %s %s" % [progress, u.upgrade_name, y])
		upgrade_weights.append(y) 

	# Select 3 random suitable upgrades
	for _n in 3:
		result.append(_get_upgrade(upgrade_weights))

	return result

func add_player_upgrade(upgrade):
	if upgrade is Upgrade:
		player_upgrades.append(upgrade)
		player_upgrade_stats[upgrade.type] += upgrade.amount
	else:
		push_error("%s is not a valid upgrade for player!" % str(upgrade))

func reset_player_upgrades():
	player_upgrades = []
	player_upgrade_stats = PLAYER_UPGRADE_STATS_BASE

# Util
func _load_upgrades_from_dir(path):
	var curr_dir = Directory.new()

	if curr_dir.open(path) == OK:
		# Start reading files (skip ., .. and invisible files)
		curr_dir.list_dir_begin(true, true)
		var file = curr_dir.get_next()
		# Iterate
		while file != "":
			if curr_dir.current_is_dir():
				var new_dir = path + file + "/"
				_load_upgrades_from_dir(new_dir)
			else:
				_load_upgrade(path + file)
			file = curr_dir.get_next()
			
func _load_upgrade(path):
	print("Loading upgrade: %s" % path)
	var upgrade = load(path)
	upgrades.append(upgrade)

# Pick random upgrade based in the 
# provided array of weights for each upgrade
func _get_upgrade(weights):
	# Calculate weight sum
	var w_sum = 0
	for w in weights:
		w_sum += w

	# Pick number between 0 and less than w_sum
	randomize()
	var rand_w = rand_range(0, w_sum - w_sum * 0.01)
	
	for i in len(weights):
		# Subtract from the random weight sum
		rand_w -= weights[i]
		# If rand_w goes under 0 this iteration
		# return the upgrade at this index
		if rand_w < 0:
			return upgrades[i]
	
	return upgrades[len(upgrades) - 1]

