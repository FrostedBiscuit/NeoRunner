extends UpgradeBase
class_name Upgrade

export(UpgradeTypes.Type) var type
export(float, 0, 1, 0.01) var amount = 0.0

func apply():
    UpgradeManager.add_player_upgrade(self)