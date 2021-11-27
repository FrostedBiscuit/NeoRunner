extends Node


func go_to_main_menu():
	_change_scene("res://levels/main_menu/main_menu.tscn")

func go_to_shooting_range():
	_change_scene("res://levels/shooting_range/shooting_range.tscn")

func go_to_1st_stage():
	_change_scene("res://levels/1st_stage/1st_stage.tscn")

func _change_scene(path):
	return get_tree().change_scene(path)