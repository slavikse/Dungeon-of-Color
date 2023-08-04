extends Node2D

onready var _status_node := $Status as Polygon2D
onready var _hint_node := $Hint as Label
onready var _common_timer_node := $CommonTimer as CommonTimer

func _process(_delta: float) -> void:
    if GState.ability_is_jumping:
        _ability_jumping()
        _ability_jump_cooldown()
    else:
        _disable_jumping()

func _ability_jumping() -> void:
    if GState.status_is_jump_cooldown:
        _start_jump_cooldown()

func _start_jump_cooldown() -> void:
    _common_timer_node.modulate = GColor.GREEN
    _common_timer_node.start(GState.delay_jump_cooldown_value)
    _hint_node.hide()

func _ability_jump_cooldown() -> void:
    if GState.status_is_jump_cooldown:
        _disable_jumping()
    else:
        _status_activate_jumping()

func _disable_jumping() -> void:
    _status_node.modulate = GColor.BLACK

func _status_activate_jumping() -> void:
    _status_node.modulate = GColor.GREEN

func _on_CommonTimer_timeout() -> void:
    GState.status_is_jump_cooldown = false
    GState.status_is_jumping = false
    _hint_node.show()
