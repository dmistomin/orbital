class_name StraightLinePattern
extends BulletPattern

export(float) var interval_between_bullets
var _timer := 0.0


func _process(delta: float) -> void:
	if is_firing:
		_timer += delta

		if _timer >= interval_between_bullets:
			_spawn_bullet_at($BulletSpawn)
			_timer = 0.0


func fire(firing_entity = Enums.Actor.Environment) -> void:
	.fire(firing_entity)


func stop() -> void:
	_timer = 0.0
	.stop()
