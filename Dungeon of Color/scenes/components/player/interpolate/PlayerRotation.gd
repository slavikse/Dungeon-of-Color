extends Tween
class_name PlayerRotation

const _DELAY_ROTATE_DURATION := 0.4

func rotate(player_node: KinematicBody2D, degrees: float) -> bool:
     var is_active := is_active()
     if not is_active:
        _interpolate_rotation(player_node, degrees)
     return is_active

func _interpolate_rotation(player_node: KinematicBody2D, degrees: float) -> void:
    #warning-ignore:RETURN_VALUE_DISCARDED
    interpolate_property(
        player_node, 'rotation_degrees',
        degrees, degrees + GNumber.RIGHT_ANGLE,
        _DELAY_ROTATE_DURATION,
        Tween.TRANS_BACK, Tween.EASE_OUT)
    #warning-ignore:RETURN_VALUE_DISCARDED
    start()
