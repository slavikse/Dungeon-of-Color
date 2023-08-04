extends Node2D

var _master_sound := AudioServer.get_bus_index('Master')

onready var _volume_node := $Volume/Volume1/Volume2 as Sprite

func _on_Button_pressed() -> void:
    #warning-ignore:RETURN_VALUE_DISCARDED
    get_tree().change_scene("res://scenes/levels/level_01/Level_01.tscn")

func _on_Exit_pressed() -> void:
    get_tree().quit()

func _on_Volume_pressed() -> void:
    _volume_node.visible = not _volume_node.visible
    AudioServer.set_bus_mute(_master_sound, not _volume_node.visible)
