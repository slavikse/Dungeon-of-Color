extends Area2D
class_name BulletArea2D

signal destroy()

onready var _collision_node := $Collision as CollisionShape2D
onready var _body_node := $Body as Sprite
onready var _destroy_node := $Destroy as Particles2D
onready var _splitting_node := $Splitting as AudioStreamPlayer2D

func _on_BulletArea2D_area_entered(_area_node: Area2D) -> void:
    _collision_node.set_deferred('disabled', true)
    _body_node.hide()
    _destroy_emitting()

func _destroy_emitting() -> void:
    _destroy_node.emitting = true
    _splitting_node.play()
    GFunc.timer_start(_destroy_node.lifetime, self, '_destroyed_timeout')
    emit_signal('destroy')

func _destroyed_timeout(timer_node: Timer) -> void:
    timer_node.queue_free()
