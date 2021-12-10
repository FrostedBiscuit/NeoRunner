extends Node

const STAGES = 1
const LEVELS_PER_STAGE = 3
const ALL_LEVELS = STAGES * LEVELS_PER_STAGE

var curr_stage
var curr_level

func start_game():
    _reset()

    LevelSwitcher.go_to_main_level()

func next_level():
    curr_level = curr_level + 1
    curr_stage = _get_stage()
    print(_get_stage())
    LevelSwitcher.go_to_main_level()

func end_game():
    LevelSwitcher.go_to_end_game_level()
    _reset()

func get_current_stage():
    return curr_stage

func get_current_stage_progress():
    var current_stage_levels = curr_level % LEVELS_PER_STAGE
    return float(current_stage_levels) / float(LEVELS_PER_STAGE)

func get_overall_progress():
    return float(curr_level) / float(STAGES * LEVELS_PER_STAGE)

# Util
func _reset():
    curr_level = 1
    curr_stage = 1

func _get_stage():
    var f_curr_level = float(curr_level)
    var f_levels_per_stage = float(LEVELS_PER_STAGE)
    return int(ceil(f_curr_level / f_levels_per_stage))