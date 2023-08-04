extends Node2D

onready var _status_node := $Status as Polygon2D

func _process(_delta: float) -> void:
    if GState.ability_is_weapon_absorb\
        and GState.status_is_weapon\
        and not GState.status_is_weapon_rotate:
        _activate_weapon()
    else:
        _disable_weapon()

func _activate_weapon() -> void:
    _status_node.modulate = GColor.RED

func _disable_weapon() -> void:
    _status_node.modulate = GColor.BLACK
