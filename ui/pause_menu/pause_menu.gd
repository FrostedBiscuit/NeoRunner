extends Control

func _on_ResumeButton_pressed():
	_unpause_game()

func _on_SettingsButton_pressed():
	push_error("Settings not implemented yet!")

func _on_QuitToMenuButton_pressed():
	LevelSwitcher.go_to_main_menu()

func _on_QuitButton_pressed():
    get_tree().quit()

func _unpause_game():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	visible = false
	owner.set_process(true)
	owner.set_physics_process(true)
