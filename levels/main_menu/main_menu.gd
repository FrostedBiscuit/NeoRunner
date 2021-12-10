extends Control

func _ready():
    UpgradeManager.reset_player_upgrades()

func _on_PlayButton_pressed():
    GameManager.start_game()
    
func _on_ShootingRangeButton_pressed():
    LevelSwitcher.go_to_shooting_range()

func _on_SettingsButton_pressed():
    print("Settings not implemented yet.")
            
func _on_QuitButton_pressed():
    get_tree().quit()