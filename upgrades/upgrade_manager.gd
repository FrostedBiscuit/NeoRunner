extends Node

# Base upgrade dictionary
const PLAYER_UPGRADE_STATS_BASE = {
    UpgradeTypes.Type.HEALTH: 0,
    UpgradeTypes.Type.AMMO: 0,
    UpgradeTypes.Type.MOVEMENT_SPEED: 0,
    UpgradeTypes.Type.RELOAD_SPEED: 0,
    UpgradeTypes.Type.DAMAGE: 0
}
# Player reference
var player = null
var player_upgrade_handler = null

# List of  all upgrades
var upgrades = []
# Current upgrades and upgrade stats for player
var player_upgrades = []
var player_upgrade_stats = PLAYER_UPGRADE_STATS_BASE

func _ready():
    _load_upgrades()
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
func _load_upgrades():
    var res_dir = Directory.new()
    var res_dir_path = "res://upgrades/resources/"

    # Check if we can open the directory
    if res_dir.open(res_dir_path) == OK:
        # Begin reading files
        res_dir.list_dir_begin()
        var res_file = res_dir.get_next()
        # Iterate through all files in directory
        while res_file != "":
            if not res_dir.current_is_dir():
                # Load resource file
                var res_file_dir = res_dir_path + res_file
                var upgrade = load(res_file_dir)
                upgrades.append(upgrade)
            res_file = res_dir.get_next()
        res_dir.list_dir_end()