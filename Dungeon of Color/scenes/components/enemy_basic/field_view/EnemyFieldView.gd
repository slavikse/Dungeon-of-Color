extends Area2D

signal check_player_visibility(player_global_position)

onready var _collision_node := $Collision as CollisionShape2D
onready var _toggle_scope_node := $ToggleScope as Timer

func _on_EnemyFieldView_area_entered(area_node: Area2D) -> void:
    if area_node is PlayerBody:
        emit_signal('check_player_visibility', area_node.global_position)

func _on_ToggleScope_timeout() -> void:
    _collision_node.set_deferred('disabled', not _collision_node.disabled)

func _on_MonitorsThePlayer_area_entered(area_node: Area2D) -> void:
    if area_node is PlayerBody:
        _toggle_scope_node.start()

func _on_MonitorsThePlayer_area_exited(area_node: Area2D) -> void:
    if area_node is PlayerBody:
        _toggle_scope_node.stop()
