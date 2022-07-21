class_name BulletSpawn
extends Sprite

const Bullet = preload("res://game/combat/bullets/Bullet.tscn")

export(int) var bullet_damage
export(int) var bullet_speed


func _ready():
	visible = false


func spawn(firing_entity):
	var bullet_manager = get_tree().get_nodes_in_group("bullet_manager")[0]
	var new_bullet = Bullet.instance()
	new_bullet.setup(firing_entity, bullet_damage, bullet_speed, -global_transform.y.normalized())
	new_bullet.transform = global_transform
	bullet_manager.add_bullet(new_bullet)
