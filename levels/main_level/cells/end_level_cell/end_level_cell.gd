extends NormalCell

func _on_EndLevelMarker_body_entered(body):
	
	if body.name != "Player":
		return

	print("Level ended!")
	
	var overall_progress = GameManager.get_overall_progress()

	if overall_progress == 1:
		GameManager.end_game()
	else:
		LevelSwitcher.go_to_upgrade_menu()
