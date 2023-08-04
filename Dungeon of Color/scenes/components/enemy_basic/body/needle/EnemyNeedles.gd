extends Area2D
class_name EnemyNeedles

const _ANIM_SHOW := 'show'
const _ANIM_HIDE := 'hide'

var _animation_name_played := ''

onready var _toggle_show_node := $ToggleShow as AnimationPlayer

func _ready() -> void:
    modulate = GColor.WHITE

func activate() -> void:
    if _animation_name_played != _ANIM_SHOW:
        _play_animation(_ANIM_SHOW)

func deactivate() -> void:
    if _animation_name_played != _ANIM_HIDE:
        _play_animation(_ANIM_HIDE)

func _play_animation(anim_name: String) -> void:
    _animation_name_played = anim_name
    _toggle_show_node.play(anim_name)
