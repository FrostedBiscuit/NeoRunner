extends NormalCell

func _on_EndLevelMarker_body_entered(_body):
	print("Area entered!")
	print("Sending player to upgrade menu")

	LevelSwitcher.go_to_upgrade_menu()
