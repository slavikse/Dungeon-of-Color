extends Node2D

onready var _status_node := $Status as Polygon2D
onready var _hint_node := $Hint as Label
onready var _common_timer_node := $CommonTimer as CommonTimer

func _process(_delta: float) -> void:
    if GState.ability_is_weapon_rotate:
        _ability_weapon_rotate()
    else:
        _disable_weapon()

func _ability_weapon_rotate() -> void:
    if GState.status_is_weapon:
        _status_weapon_rotate()
    else:
        _disable_weapon()

func _disable_weapon() -> void:
    _status_node.modulate = GColor.BLACK

func _status_weapon_rotate() -> void:
    if GState.status_is_weapon_rotate:
        _disable_weapon()
        _start_weapon_rotate_cooldown()
    else:
        _status_activate_weapon_rotate()

func _start_weapon_rotate_cooldown() -> void:
    _common_timer_node.modulate = GColor.YELLOW
    _common_timer_node.start(GState.delay_rotate_duration)
    _hint_node.hide()

func _status_activate_weapon_rotate() -> void:
    _status_node.modulate = GColor.YELLOW

func _on_CommonTimer_timeout() -> void:
    GState.status_is_weapon_rotate = false
    _hint_node.show()
