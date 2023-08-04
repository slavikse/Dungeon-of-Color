extends Node2D
class_name UIJumpMultiplier

onready var _value_node := $Value as Label

func update() -> void:
    _value_node.text = str(GState.player_jump_multiplier)

func _on_Minus_pressed() -> void:
    if GState.player_jump_multiplier > 0 and GState.player_jump_multiplier > 0:
        GState.player_jump_multiplier -= 1
        GState.player_leveling_points += 1

func _on_Plus_pressed() -> void:
    if GState.player_leveling_points > 0 and GState.player_jump_multiplier < GState.PLAYER_JUMP_MULTIPLIER_MAX:
        GState.player_leveling_points -= 1
        GState.player_jump_multiplier += 1
