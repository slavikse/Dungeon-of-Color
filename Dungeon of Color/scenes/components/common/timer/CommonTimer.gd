extends Node2D
class_name CommonTimer

export(bool) var _is_hidden := false

signal timeout()

var _is_timeout := true
var _countdown_time := -1.0
var _time_step := -1.0

onready var _value_node := $Value as Label
onready var _timer_node := $Timer as Timer

func _ready() -> void:
    _value_node.text = ''

func start(time: float, step := 0.1) -> void:
    if _is_timeout:
        _is_timeout = false
        _countdown_time = time - step
        _time_step = step
        _show()
        _timer_start()

func stop() -> void:
    _timer_node.stop()
    _countdown_time = -1.0
    _timeout()

func _show() -> void:
    if not _is_hidden:
        show()

func _timer_start() -> void:
    _value_node.text = _add_zero()
    _timer_node.start(_time_step)

func _add_zero() -> String:
    var rest := fmod(_countdown_time, 1)
    var result := str(_countdown_time)
    # fix: Простое сравнение не работает.
    if len(str(rest)) == 1:
        result += '.0'
    return result

func _timeout() -> void:
    if _countdown_time <= 0:
        _is_timeout = true
        hide()
        emit_signal('timeout')
    else:
        _timer_start()

func _on_Timer_timeout() -> void:
    _countdown_time -= _time_step
    _timeout()

func has_timeout() -> bool: return _is_timeout
