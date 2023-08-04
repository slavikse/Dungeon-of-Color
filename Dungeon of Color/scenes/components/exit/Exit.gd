extends Area2D

func _on_Exit_area_entered(area_node: Area2D) -> void:
    if area_node is PlayerBody:
        (area_node as PlayerBody).game_end()
