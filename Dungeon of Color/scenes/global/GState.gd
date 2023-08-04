extends Node2D

func _ready() -> void:
    update_delay_jump_cooldown_value()

# ABILITY #
#warning-ignore:UNUSED_CLASS_VARIABLE
var ability_is_jumping := false

#warning-ignore:UNUSED_CLASS_VARIABLE
var ability_is_weapon := true
#warning-ignore:UNUSED_CLASS_VARIABLE
var ability_is_weapon_rotate := false
#warning-ignore:UNUSED_CLASS_VARIABLE
var ability_is_weapon_absorb := true

# PLAYER #
#warning-ignore:UNUSED_CLASS_VARIABLE
var player_leveling_points := 0
#warning-ignore:UNUSED_CLASS_VARIABLE
var player_rotation_degrees := 0.0

#warning-ignore:UNUSED_CLASS_VARIABLE
var player_movement_speed := 150
#warning-ignore:UNUSED_CLASS_VARIABLE
const PLAYER_MOVEMENT_SPEED_MIN := 100
#warning-ignore:UNUSED_CLASS_VARIABLE
const PLAYER_MOVEMENT_SPEED_MAX := 300
#warning-ignore:UNUSED_CLASS_VARIABLE
const PLAYER_MOVEMENT_SPEED_STEP := 50

#warning-ignore:UNUSED_CLASS_VARIABLE
var player_jump_multiplier := 1
#warning-ignore:UNUSED_CLASS_VARIABLE
var PLAYER_JUMP_MULTIPLIER_MAX := 6

#warning-ignore:UNUSED_CLASS_VARIABLE
var player_shot_bullet_lifetime := 0.4
#warning-ignore:UNUSED_CLASS_VARIABLE
var player_shot_linear_multiplier := 1.0
#warning-ignore:UNUSED_CLASS_VARIABLE
var player_shot_force_multiplier := 0.6

#warning-ignore:UNUSED_CLASS_VARIABLE
var player_is_game_over := false

# DELAY #
#warning-ignore:UNUSED_CLASS_VARIABLE
var DELAY_DOWNGRADE := 0.2 # 20%
#warning-ignore:UNUSED_CLASS_VARIABLE
var delay_jump_cooldown := 6.0
const DELAY_JUMP_COOLDOWN_MAX := 6
# Эта переменная используется при расчётах.
#warning-ignore:UNUSED_CLASS_VARIABLE
var delay_jump_cooldown_value := -1.0
#warning-ignore:UNUSED_CLASS_VARIABLE
func update_delay_jump_cooldown_value() -> void:
    delay_jump_cooldown_value = float(delay_jump_cooldown - (delay_jump_cooldown * DELAY_DOWNGRADE))

#warning-ignore:UNUSED_CLASS_VARIABLE
var delay_rotate_duration := 6.0
#warning-ignore:UNUSED_CLASS_VARIABLE
const DELAY_ROTATE_DURATION_MAX := 6

#warning-ignore:UNUSED_CLASS_VARIABLE
var delay_shot_cooldown := 6.0
#warning-ignore:UNUSED_CLASS_VARIABLE
const DELAY_SHOT_COOLDOWN_MAX := 6

# STATUS #
#warning-ignore:UNUSED_CLASS_VARIABLE
var status_is_weapon := false
#warning-ignore:UNUSED_CLASS_VARIABLE
var status_is_weapon_rotate := false
#warning-ignore:UNUSED_CLASS_VARIABLE
var status_is_weapon_absorb := false

#warning-ignore:UNUSED_CLASS_VARIABLE
var status_is_jumping := false
#warning-ignore:UNUSED_CLASS_VARIABLE
var status_is_jump_cooldown := false

# COLORS #
#warning-ignore:UNUSED_CLASS_VARIABLE
var colors_weapon_guns := [GColor.RED, GColor.GREEN, GColor.BLUE, GColor.YELLOW] # = _COLORS_IMMUTABLE

# ENEMY #
#warning-ignore:UNUSED_CLASS_VARIABLE
var enemy_bullet_lifetime := 1.2
#warning-ignore:UNUSED_CLASS_VARIABLE
var enemy_shot_linear_multiplier := 1.0
#warning-ignore:UNUSED_CLASS_VARIABLE
var enemy_shot_force_multiplier := 0.6

###

# При изменениях, приводить в соответствие с переменными выше.
func reset_pumping() -> void:
    ability_is_jumping = false
    ability_is_weapon = true
    ability_is_weapon_rotate = false
    ability_is_weapon_absorb = true
    player_leveling_points = 0
    player_rotation_degrees = 0.0
    player_movement_speed = 150
    player_jump_multiplier = 1

    player_shot_bullet_lifetime = 0.4
    player_shot_linear_multiplier = 1.0
    player_shot_force_multiplier = 0.6

    player_is_game_over = false
    delay_jump_cooldown = 6.0
    delay_jump_cooldown_value = -1.0
    update_delay_jump_cooldown_value()

    delay_rotate_duration = 6.0
    delay_shot_cooldown = 6.0
    status_is_weapon = false
    status_is_weapon_rotate = false
    status_is_weapon_absorb = false

    status_is_jumping = false
    status_is_jump_cooldown = false
    colors_weapon_guns = [GColor.RED, GColor.GREEN, GColor.BLUE, GColor.YELLOW] # = _COLORS_IMMUTABLE

    enemy_bullet_lifetime = 1.2
    enemy_shot_linear_multiplier = 1.0
    enemy_shot_force_multiplier = 0.6
