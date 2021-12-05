extends Node

# Player reference
var player = null
var player_upgrade_handler = null

var upgrades = []

func _ready():
    _load_upgrades()

func get_3_random_upgrades():
    var len_upgrades = len(upgrades)
    var result = []

    for _n in 3:
       result.append(upgrades[int(floor(rand_range(0, len_upgrades)))])
    
    return result

# Util
func _load_upgrades():
    upgrades = [
        preload("res://upgrades/weapon_changers/test_pistol_changer.tres"),
        preload("res://upgrades/weapon_changers/test_smg_changer.tres")
    ]