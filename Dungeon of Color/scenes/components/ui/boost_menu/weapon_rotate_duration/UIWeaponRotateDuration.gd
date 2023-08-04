extends Node2D
class_name UIWeaponRotateDuration

onready var _value_node := $Value as Label

func update() -> void:
    _value_node.text = str(GState.delay_rotate_duration)

func _on_Minus_pressed() -> void:
    if GState.player_leveling_points > 0 and GState.delay_rotate_duration > 1:
        GState.player_leveling_points -= 1
        GState.delay_rotate_duration -= 1

func _on_Plus_pressed() -> void:
    if GState.delay_rotate_duration < GState.DELAY_ROTATE_DURATION_MAX:
        GState.delay_rotate_duration += 1
        GState.player_leveling_points += 1
