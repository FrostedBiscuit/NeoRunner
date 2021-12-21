extends UpgradeBase
class_name WeaponPickup

export var weapon_slug = ""

func apply():
    WeaponManager.set_current_player_weapon(weapon_slug)
