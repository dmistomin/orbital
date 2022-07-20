class_name BulletSpawn
extends Sprite

const Bullet = preload("res://game/combat/bullets/Bullet.tscn")

export(int) var bullet_damage
export(int) var bullet_speed


func _ready():
	visible = false


func spawn(firing_entity):
	var new_bullet = Bullet.instance()
	new_bullet.setup(firing_entity, bullet_damage, bullet_speed, Vector2(0, -1))
	new_bullet.transform = global_transform
	get_parent().bullets.add_bullet(new_bullet)
