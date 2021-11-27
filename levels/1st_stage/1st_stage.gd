extends Node

# Player scene
export(PackedScene) var player = null

func _ready():
	_spawn_player()

func _spawn_player():
	if player == null:
		push_error("No Player scene set!!")
		return

	var player_instance = player.instance()
	player_instance.transform.origin = $PlayerSpawn.transform.origin
	player_instance.rotation_degrees = $PlayerSpawn.rotation_degrees

	self.add_child(player_instance)
	
