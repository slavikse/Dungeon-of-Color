extends Node2D
class_name UIWeaponRotate

onready var _value_node := $Value as CheckBox

func update() -> void:
    _value_node.pressed = GState.ability_is_weapon_rotate

func _on_Value_pressed() -> void:
    if GState.ability_is_weapon_rotate:
        GState.ability_is_weapon_rotate = false
        GState.player_leveling_points += 1

    elif GState.player_leveling_points > 0:
        GState.player_leveling_points -= 1
        GState.ability_is_weapon_rotate = true
