extends Node

# Player references
var player = null
var player_weapon_handler = null

# Weapons
var all_weapons = {}

# Slug for the current player weapon
var current_weapon

func _ready():
	all_weapons = _load_weapons()

	current_weapon = "test_pistol"

# Set player's weapon to manager's current weapon
func reset_player_weapon():
	set_player_weapon(current_weapon)

# Only set current player weapon slug
func set_current_player_weapon(weapon_slug):
	if not weapon_slug in all_weapons:
		push_error("Weapon with slug %s not found" % weapon_slug)
		return

	current_weapon = weapon_slug

# Set player's weapon
func set_player_weapon(weapon_slug):
	if not player or not player_weapon_handler:
		push_error("Player and/or player weapon handler not set!")
		return
	
	if not weapon_slug in all_weapons:
		push_error("Weapon with slug %s not found" % weapon_slug)
		return
		
	current_weapon = weapon_slug
	player_weapon_handler.set_weapon(all_weapons[weapon_slug])
	
# Util
func _load_weapons():
	var result = {
		"test_pistol": preload("res://weapons/firearm/test_pistol/test_pistol.tscn"),
		"test_smg": preload("res://weapons/firearm/test_smg/test_smg.tscn"),
		"test_shotgun": preload("res://weapons/firearm/test_shotgun/test_shotgun.tscn")
	}

	return result