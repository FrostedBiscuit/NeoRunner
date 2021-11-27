extends Spatial

var ray = null
var hud = null
var weapon_handler = null

func _ready():
    # Get interact ray and add player as exception
    ray = get_parent().get_node("Camera/InteractRayCast")
    ray.add_exception(owner)

    hud = owner.get_node("HUD")

    weapon_handler = get_parent().get_node("Weapons")

func _physics_process(_delta):
    var hit = ray.get_collider() if ray.is_colliding() else null

    if hit and hit is WeaponProp:
        _set_weapon_name_label(hit.weapon_name)
    else:
        _clear_weapon_name()

func _input(_event):
    # Process interact input
    if Input.is_action_pressed("interact"):
        _interact()

func _interact():
    # Check if weapon is currently equipping
    if weapon_handler.is_weapon_equipping():
        return

    # Check if ray is set
    if not ray:
        push_error("Cannot find InteractRayCast!")
        return

    # Update ray
    ray.force_raycast_update()

    # Check for collision
    if ray.is_colliding():
        print("Hit something!")
        var collider = ray.get_collider()
        if collider is WeaponProp:
            # Interact with weapon prop
            collider.equip_weapon()

func _set_weapon_name_label(name):
    if not hud:
        push_error("No HUD found!!")
        return

    if len(name) > 0 and name is String:
        hud.update_weapon_name(name)

func _clear_weapon_name():
    if not hud:
        push_error("No HUD found!!")
        return

    hud.clear_weapon_name()