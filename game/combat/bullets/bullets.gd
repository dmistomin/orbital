class_name Bullets
extends Node


func _physics_process(delta: float) -> void:
	for b in $ActiveBullets.get_children():
		b.move_and_collide(b.velocity * b.speed * delta)


func setup():
	for p in $Patterns.get_children():
		p.setup(self)


func add_bullet(new_bullet):
	print("bullets.add_bullet()")
	$ActiveBullets.add_child(new_bullet)
