extends Node2D
class_name UIJumping

onready var _value_node := $Value as CheckBox

func update() -> void:
    _value_node.pressed = GState.ability_is_jumping

func _on_Value_pressed() -> void:
    if GState.ability_is_jumping:
        GState.ability_is_jumping = false
        GState.player_leveling_points += 1

    elif GState.player_leveling_points > 0:
        GState.player_leveling_points -= 1
        GState.ability_is_jumping = true
