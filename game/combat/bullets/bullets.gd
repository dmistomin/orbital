class_name Bullets
extends Node

export(Vector2) var x_limits = Vector2(500, 1420)
export(Vector2) var y_limits = Vector2(0, 1080)


func _physics_process(delta: float) -> void:
	for b in get_children():
		b.move_and_collide(b.velocity * b.speed * delta)

		if (b.global_position.x < x_limits[0]) or (b.global_position.x > x_limits[1]):
			b.queue_free()
		elif (b.global_position.y < y_limits[0]) or (b.global_position.y > y_limits[1]):
			b.queue_free()


func add_bullet(new_bullet):
	add_child(new_bullet)
