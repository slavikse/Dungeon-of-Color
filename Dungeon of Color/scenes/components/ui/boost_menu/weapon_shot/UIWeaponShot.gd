extends Node2D
class_name UIWeaponShot

const _BULLET_LIFETIME_MINIMUM := 0.2
const _BULLET_LIFETIME_MAXUMUM := 1.0
const _STEP := 0.2

onready var _value_node := $Value as Label

func update() -> void:
    _value_node.text = str(GState.player_shot_bullet_lifetime)

func _on_Minus_pressed() -> void:
    if GState.player_shot_bullet_lifetime > _BULLET_LIFETIME_MINIMUM:
        GState.player_leveling_points += 1
        GState.player_shot_bullet_lifetime -= _STEP
        GState.player_shot_linear_multiplier -= _STEP
        GState.player_shot_force_multiplier -= _STEP

func _on_Plus_pressed() -> void:
    if GState.player_leveling_points > 0 and GState.player_shot_bullet_lifetime < _BULLET_LIFETIME_MAXUMUM:
        GState.player_leveling_points -= 1
        GState.player_shot_bullet_lifetime += _STEP
        GState.player_shot_linear_multiplier += _STEP
        GState.player_shot_force_multiplier += _STEP
