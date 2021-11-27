extends Spatial

var weapons = {}

func _ready():

	# Add player as exception to raycast
	get_parent().get_node("Camera/AttackRayCast").add_exception(owner)

	weapons = {
		"Primary": $Hand.get_child(0)
	}

	for w in weapons:
		if weapons[w] != null:
			_weapon_setup(weapons[w])

	weapons["Primary"].visible = true

func set_weapon(weapon_resource):
	# Spawn new weapon
	var weapon = _spawn_weapon(weapon_resource, $WeaponPosition.transform.origin)

	# Set the weapon up
	_weapon_setup(weapon)
	weapon.visible = true

	# Reassign weapon slot
	weapons["Primary"].queue_free()
	weapons["Primary"] = weapon
	weapons["Primary"].equip()

# Player controlled attacking
func attack():
	if weapons["Primary"] is Firearm:
		weapons["Primary"].start_shooting()
	# Implement attacking for melee weapons here

func stop_attacking():
	if weapons["Primary"] is Firearm:
		weapons["Primary"].stop_shooting()
	# Implement attacking for melee weapons here

# Player controlled reloading
func reload():
	if not weapons["Primary"] is Firearm:
		# We can't reload melee weapons
		return

	weapons["Primary"].start_reload()

func is_weapon_equipping():
	if not weapons["Primary"]:
		return false

	return not weapons["Primary"].is_equipped

func _spawn_weapon(weapon, pos = null):
	# Check if weapon name is valid
	if not weapon:
		push_error("Tried to set null weapon!")
		return

	# Spawn the weapon into the game world
	var instance = weapon.instance()

	# Add it as a child of Hand node
	$Hand.add_child(instance)

	if pos != null:
		instance.transform.origin = pos

	return instance

func _weapon_setup(w):
	w.weapon_manager = self
	w.player = owner
	w.visible = false
	w.ray = get_parent().get_node("Camera/AttackRayCast")