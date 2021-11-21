extends Firearm

class_name TestShotgun

# Weapon parameters
export var spread = 3
export var num_pellets = 5

# Override Firearm's shoot() function
func shoot():
	# Decrement ammo
	current_ammo = clamp(current_ammo - 1, 0, magazine_size)

	# Save ray's intial rotation
	var initial_ray_rotation = ray.rotation_degrees

	for _i in range(num_pellets):
		# Calculate a random rotation and check for hits
		var random_rotation = Vector3(rand_range(-spread, spread), rand_range(-spread, spread), 0)
		ray.rotation_degrees = initial_ray_rotation + random_rotation
		ray.force_raycast_update()

		# If we find a hit, spawn a decal (for now)
		if ray.is_colliding():
			var col_pos = ray.get_collision_point()
			var col_rot = ray.get_collision_normal()
			_spawn_shot_decal(col_pos, col_rot)
	
	# Reset ray rotation to initial rotation
	ray.rotation_degrees = initial_ray_rotation
