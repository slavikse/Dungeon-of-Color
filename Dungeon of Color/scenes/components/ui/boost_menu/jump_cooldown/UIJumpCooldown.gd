extends Node2D
class_name UIJumpCooldown

onready var _value_node := $Value as Label

func update() -> void:
    _value_node.text = str(GState.delay_jump_cooldown)

func _on_Minus_pressed() -> void:
    if GState.player_leveling_points > 0 and GState.delay_jump_cooldown > 1:
        GState.player_leveling_points -= 1
        GState.delay_jump_cooldown -= 1
        GState.update_delay_jump_cooldown_value()

func _on_Plus_pressed() -> void:
    if GState.delay_jump_cooldown < GState.DELAY_JUMP_COOLDOWN_MAX:
        GState.delay_jump_cooldown += 1
        GState.update_delay_jump_cooldown_value()
        GState.player_leveling_points += 1
