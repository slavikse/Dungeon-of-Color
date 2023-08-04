extends Area2D

signal rotate_right()

const _DEACTIVATED_MASK := 0 # Null
const _ACTIVATED_MASK := 1 # Player

onready var _reload_node := $Reload as Timer
onready var _rotate_node := $Rotate as AnimationPlayer
onready var _rotation_node := $Rotation as AudioStreamPlayer2D

func _ready() -> void:
    _activate()

func _activate() -> void:
    collision_mask = _ACTIVATED_MASK
    modulate = GColor.YELLOW
    _rotate_node.play('rotate')
    _rotation_node.play()

func _on_WeaponTurn_area_entered(area_node: Area2D) -> void:
    if area_node is PlayerBody:
        _weapons_rotate()

func _weapons_rotate() -> void:
    if GState.status_is_weapon:
        emit_signal('rotate_right')
        _deactivate()
        _reload_node.start()

func _deactivate() -> void:
    collision_mask = _DEACTIVATED_MASK
    modulate = GColor.BLACK
    _rotate_node.stop()
    _rotation_node.stop()

func _on_Reload_timeout() -> void:
    _activate()
