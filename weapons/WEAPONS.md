# WEAPONS
## Architecture
### Base Weapon class
All weapons have a base ```Weapon``` class, which holds some essential values all weapons have. This consists of references to scene objects and meta data like weapon name and slug.

### Weapon category classes
There are also 2 distinct weapon types:
* ```Firearm``` - base class for all hit scan weapons (rifles, pistols, etc)
* ```Melee``` - base class for all melee weapons (no melee weapons have been implemented till now)

### WeaponManager
There is also a ```WeaponManager``` script singelton, that works like a dictionary for weapons.
It contains a method to set the player's weapon based on it's slug (short name).

### WeaponHandler
The player object contains a script, which is responsible for handling the player's weapons.
The aformentioned WeaponManager has a reference to the player and the handler.

## Adding a new weapon

Adding a new weapon to the game is easy!
1. Create a 3D scene and set it up, the hirearchy should look something like this:
```
Weapon - call this node by the name of the weapon
├──Root
│  └──Mesh
└──AnimationPlayer
```
2. Create a script by the name of the weapon. It should inherit from the appropriate category class (```Firearm``` for guns and ```Melee``` for melee weapons) and attach it to the root of the scene.
3. Set all the configurable values from the inspector (weapon name, slug, etc).
4. Create ```Equip```, ```Fire``` (```Attack``` for melee weapons) and ```Reload``` (if you are adding a firearm) animations.
Make sure that the ```Fire``` (or the corresponding animation for a melee weapon) and ```Reload``` animations have a function calling track, which will call the ```fire()``` and ```reload()``` functions at the appropriate animation frame.
5. Add an entry to the dictionary, being created in the ```weapon_manager.gd``` script. The entry consists of the slug of the weapon and a preloaded resource (check the code for an example).
6. Profit!