class_name Wave
extends Node2D

export(bool) var is_active
export(bool) var all_spawned
export(bool) var has_been_cleared
export(Vector2) var offset

var _spawn_points := []
var _time := 0.0


func _process(delta: float) -> void:
	if is_active and not all_spawned:
		_time += delta

		for spawn_point_idx in range(_spawn_points.size()):
			var current_point = _spawn_points[spawn_point_idx]

			if not current_point.has_spawned:
				if _time >= current_point.delay:
					current_point.spawn()

			if spawn_point_idx == _spawn_points.size() - 1:
				if current_point.has_spawned:
					all_spawned = true


func start() -> void:
	is_active = true
	visible = true
	_spawn_points = get_children()

	if offset != Vector2():
		position += offset
