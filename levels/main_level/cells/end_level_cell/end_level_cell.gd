extends NormalCell

func _on_EndLevelMarker_body_entered(_body):
	print("Level ended!")

	LevelSwitcher.go_to_upgrade_menu()
