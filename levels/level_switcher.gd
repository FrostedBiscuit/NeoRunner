extends Node


func go_to_main_menu():
	_change_scene("res://levels/main_menu/main_menu.tscn")

func go_to_shooting_range():
	_change_scene("res://levels/shooting_range/shooting_range.tscn")

func go_to_main_level():
	_change_scene("res://levels/main_level/main_level.tscn")

func go_to_upgrade_menu():
	_change_scene("res://levels/upgrade_menu/upgrade_menu.tscn")

func go_to_end_game_level():
	_change_scene("res://levels/end_game_level/end_game_level.tscn")

func _change_scene(path):
	return get_tree().change_scene(path)