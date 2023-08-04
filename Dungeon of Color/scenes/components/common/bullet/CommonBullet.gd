extends RigidBody2D
class_name CommonBullet

var _gunman := -1

onready var _collision_node := $Collision as CollisionShape2D
onready var _time_limit_node := $TimeLimit as Timer
onready var _bullet_area2d_node := $BulletArea2D as Area2D # BulletArea2D
onready var _destruction_node := $Destruction as Particles2D
onready var _shot_node := $Shot as AudioStreamPlayer2D
onready var _splitting_node := $Splitting as AudioStreamPlayer2D

func get_gunman() -> int: return _gunman # G.Gunman.*

func setup(new_position: Vector2, color: Color) -> CommonBullet:
    position = new_position
    modulate = color
    return self

func launch(gunman: int, velocity: Vector2) -> void:
    G.root_node.add_child(self)
    _gunman = gunman
    _shot_node.play()
    _who_shooting(velocity)

func _who_shooting(velocity: Vector2) -> void:
    if _gunman == int(G.Gunman.PLAYER):
        _launch_player(velocity)
        _time_limit_node.start(GState.player_shot_bullet_lifetime)
    elif _gunman == int(G.Gunman.ENEMY):
        _launch_enemy(velocity)
        _time_limit_node.start(GState.enemy_bullet_lifetime)

func _launch_player(velocity: Vector2) -> void:
    linear_velocity = velocity * GState.player_shot_linear_multiplier
    applied_force = velocity * GState.player_shot_force_multiplier

func _launch_enemy(velocity: Vector2) -> void:
    linear_velocity = velocity * GState.enemy_shot_linear_multiplier
    applied_force = velocity * GState.enemy_shot_force_multiplier

func _on_BulletArea2D_destroy() -> void:
    _collision_disabled()
    GFunc.timer_start(_destruction_node.lifetime, self, '_destroy_ended')

func _collision_disabled() -> void:
    _collision_node.set_deferred('disabled', true)

func _on_TimeLimit_timeout() -> void:
    _collision_disabled()
    _bullet_area2d_node.hide()
    _destruction_node.emitting = true
    _splitting_node.play()
    GFunc.timer_start(_destruction_node.lifetime, self, '_destroy_ended')

func _destroy_ended(timer_node: Timer) -> void:
    timer_node.queue_free()
    queue_free()
