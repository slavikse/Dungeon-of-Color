extends Node2D
class_name UIWeaponShotCooldown

onready var _value_node := $Value as Label

func update() -> void:
    _value_node.text = str(GState.delay_shot_cooldown)

func _on_Minus_pressed() -> void:
    if GState.player_leveling_points > 0 and GState.delay_shot_cooldown > 1:
        GState.player_leveling_points -= 1
        GState.delay_shot_cooldown -= 1

func _on_Plus_pressed() -> void:
    if GState.delay_shot_cooldown < GState.DELAY_SHOT_COOLDOWN_MAX:
        GState.player_leveling_points += 1
        GState.delay_shot_cooldown += 1
