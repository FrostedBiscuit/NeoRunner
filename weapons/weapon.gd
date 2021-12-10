extends Spatial
class_name Weapon

# References
var weapon_manager = null
var player = null
var animation_player
var ray = null

# Weapon states
export var is_equipped = false

# Weapon parameters
export var weapon_name = "Weapon"
export var weapon_slug = "wpn"
export var damage = 0

# Equip and unequip speeds
export var equip_speed = 0.1

func equip():
	animation_player.play("Equip", equip_speed)

func is_equip_finished():
	return is_equipped

func on_animation_finish(anim_name):
	match anim_name:
		"Equip":
			is_equipped = true

# Util
func _get_damage():
	var upgrade_amt = UpgradeManager.player_upgrade_stats[UpgradeTypes.Type.DAMAGE]
	var result = damage * (1 + upgrade_amt) if upgrade_amt > 0 else damage
	return result