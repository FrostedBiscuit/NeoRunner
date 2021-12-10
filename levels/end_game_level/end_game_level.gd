extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_MainMenuButton_pressed():
	LevelSwitcher.go_to_main_menu()
