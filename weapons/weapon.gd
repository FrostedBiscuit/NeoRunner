extends Spatial
class_name Weapon

# References
var weapon_manager = null
var player = null
var animation_player
var ray = null

# Weapon states
var is_equipped = false

# Weapon parameters
export var weapon_name = "Weapon"
export var weapon_slug = "wpn"

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