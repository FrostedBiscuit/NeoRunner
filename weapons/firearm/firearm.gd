extends Weapon
class_name Firearm

# Weapon states
var is_firing = false
var is_reloading = false

# Weapon parameters
export var magazine_size = 10
onready var current_ammo = _get_magazine_size()

export var firerate = 1.0
export var reload_speed = 1.0

# VFX
export(PackedScene) var shot_decal = null

func _ready():
	animation_player = $AnimationPlayer
	animation_player.connect("animation_finished", self, "on_animation_finish")
	pass

func on_animation_finish(anim_name):
	.on_animation_finish(anim_name)

	match anim_name:
		"Reload":
			is_reloading = false
		"Fire":
			is_firing = false

# Shoot
func start_shooting():
	if _can_fire():
		is_firing = true
		animation_player.get_animation("Fire").loop = true
		animation_player.play("Fire", -1, firerate)
	elif is_firing:
		stop_shooting()

func stop_shooting():
	is_firing = false
	animation_player.get_animation("Fire").loop = false

func shoot():
	current_ammo = clamp(current_ammo - 1, 0, _get_magazine_size())

	ray.force_raycast_update()

	if ray.is_colliding():
		var collision_pos = ray.get_collision_point()
		var collision_rot = ray.get_collision_normal()
		_spawn_shot_decal(collision_pos, collision_rot)

# Reload
func start_reload():
	if _can_reload():
		is_firing = false
		animation_player.play("Reload", -1, _get_reload_speed())
		is_reloading = true
	
func reload():
	current_ammo = _get_magazine_size()

# Util
func _can_fire():
	return current_ammo > 0 and not is_reloading and not is_firing

func _can_reload():
	return current_ammo < _get_magazine_size() and not is_reloading and not is_firing

func _spawn_shot_decal(position, rotation):
	var decal = shot_decal.instance()
	var root = get_tree().root
	var scene_root = root.get_child(root.get_child_count() - 1)

	decal.transform.origin = position
	decal.rotation_degrees = rotation
	# decal.global_transform.rotation_degrees = rotation

	scene_root.add_child(decal)

func _get_reload_speed():
	var upgrade_amt = UpgradeManager.player_upgrade_stats[UpgradeTypes.Type.RELOAD_SPEED]
	print(upgrade_amt)
	var result = reload_speed * (1 + upgrade_amt) if upgrade_amt > 0 else reload_speed
	return result

func _get_magazine_size():
	var upgrade_amt = UpgradeManager.player_upgrade_stats[UpgradeTypes.Type.AMMO]
	var result = magazine_size * (1 + upgrade_amt) if upgrade_amt > 0 else magazine_size
	return int(result)