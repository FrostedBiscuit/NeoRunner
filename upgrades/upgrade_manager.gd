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
    var len_upgrades = len(upgrades)
    var result = []

    for _n in 3:
       result.append(upgrades[int(floor(rand_range(0, len_upgrades)))])
    
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
