extends Control

func update_weapon_name(name):
	$WeaponName.visible = true
	$WeaponName.text = name

func clear_weapon_name():
	$WeaponName.text = ""
	$WeaponName.visible = false