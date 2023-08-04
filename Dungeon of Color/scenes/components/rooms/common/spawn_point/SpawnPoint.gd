extends Position2D

onready var _visible_object_node := $VisibleObject as Polygon2D

func _ready() -> void:
    _visible_object_node.queue_free()
