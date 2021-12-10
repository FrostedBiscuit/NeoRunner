extends Node

# Upgrade buttons
onready var upgrade_btn_1 = get_node("MainContainer/Upgrades/InnerContainer/UpgradeButton1")
onready var upgrade_btn_2 = get_node("MainContainer/Upgrades/InnerContainer/UpgradeButton2")
onready var upgrade_btn_3 = get_node("MainContainer/Upgrades/InnerContainer/UpgradeButton3")

# Upgrades
var upgrades = []

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	upgrades = UpgradeManager.get_3_random_upgrades()

	upgrade_btn_1.text = upgrades[0].upgrade_name
	upgrade_btn_2.text = upgrades[1].upgrade_name
	upgrade_btn_3.text = upgrades[2].upgrade_name

func _on_UpgradeButton1_pressed():
	_button_pressed(0)

func _on_UpgradeButton2_pressed():
	_button_pressed(1)

func _on_UpgradeButton3_pressed():
	_button_pressed(2)

# Util
func _button_pressed(upgrade_nr):
	_apply_upgrade(upgrade_nr)
	yield(get_tree().create_timer(1.0), "timeout")

	GameManager.next_level()

func _disable_all_buttons():
	upgrade_btn_1.disabled = true
	upgrade_btn_2.disabled = true
	upgrade_btn_3.disabled = true

func _apply_upgrade(upgrade_nr):
	_disable_all_buttons()
	upgrades[upgrade_nr].apply()
	print("Applied upgrade: %s" % upgrades[upgrade_nr].upgrade_name)
