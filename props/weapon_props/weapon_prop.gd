extends Spatial

class_name WeaponProp

export(PackedScene) var weapon

var weapon_slug
var weapon_name

func _ready():
	# Check if weapon variable is even set
	if not weapon:
		push_error("No weapon set!")
		return

	# Create new instance
	var instance = weapon.instance()

	# Check if the object we are trying to spawn is correct
	if not instance is Weapon:
		push_error("Invalid weapon set!")
		instance.queue_free()
		return

	# Save weapon slug and name
	weapon_slug = instance.weapon_slug
	weapon_name = instance.weapon_name
	
	# Cleanup
	$TempIndicator.queue_free()
	self.add_child(instance)

func equip_weapon():
	print("Equipping %s" % weapon_slug)
	WeaponManager.set_player_weapon(weapon_slug)