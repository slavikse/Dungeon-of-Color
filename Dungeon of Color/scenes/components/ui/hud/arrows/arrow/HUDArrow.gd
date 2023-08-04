extends Node2D

onready var _texture_node := $Texture as Polygon2D
onready var _texture_arrow_node := $Texture/Arrow as Polygon2D
onready var _common_timer_node := $CommonTimer as CommonTimer

func _ready() -> void:
    _hide_timer()

func set_texture_color(color: Color) -> void:
    _texture_node.modulate = color

func get_texture_color() -> Color: return _texture_node.modulate

func set_timer_color(color: Color) -> void:
    _common_timer_node.modulate = color

func timer_start() -> void:
    _common_timer_node.start(GState.delay_shot_cooldown)
    _show_timer()

func _show_timer() -> void:
    _common_timer_node.show()
    _texture_arrow_node.hide()

func timer_stop() -> void:
    _common_timer_node.stop()

func _hide_timer() -> void:
    _common_timer_node.hide()
    _texture_arrow_node.show()

func _on_CommonTimer_timeout() -> void:
    _hide_timer()
