extends Node2D
class_name UIMovementSpeed

onready var _value_node := $Value as Label

func update() -> void:
    _value_node.text = str(GState.player_movement_speed)

func _on_Minus_pressed() -> void:
    if GState.player_movement_speed > GState.PLAYER_MOVEMENT_SPEED_MIN:
        GState.player_movement_speed -= GState.PLAYER_MOVEMENT_SPEED_STEP
        GState.player_leveling_points += 1

func _on_Plus_pressed() -> void:
    if GState.player_leveling_points > 0 and GState.player_movement_speed < GState.PLAYER_MOVEMENT_SPEED_MAX:
        GState.player_leveling_points -= 1
        GState.player_movement_speed += GState.PLAYER_MOVEMENT_SPEED_STEP
