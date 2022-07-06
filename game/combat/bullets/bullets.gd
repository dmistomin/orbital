class_name Bullets
extends Node


func _physics_process(delta: float) -> void:
	for b in get_children():
		b.move_and_collide(b.velocity * b.speed * delta)


func add_bullet(new_bullet):
	add_child(new_bullet)
