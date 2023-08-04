extends Node2D
class_name PlayerJump

onready var _jerk_node := $Jerk as AudioStreamPlayer2D

func can_jump(movement_instance) -> void:
    if movement_instance.has_jump_animation():
        _play_jump_sound()

func _play_jump_sound() -> void:
    _jerk_node.play()
