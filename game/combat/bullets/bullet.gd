class_name Bullet
extends KinematicBody2D

export(Enums.Actor) var belongs_to
export(int) var damage
export(int) var speed
export(Vector2) var velocity


func setup(shooter, dmg, spd, vel):
	belongs_to = shooter
	damage = dmg
	speed = spd
	velocity = vel

	if belongs_to == Enums.Actor.PLAYER:
		$PlayerBulletSprite.visible = true
	else:
		$EnemyBulletSprite.visible = true
