class_name BulletPattern
extends Node2D

export(bool) var is_firing = false

var bullets
var firing_entity


func setup(bullet_manager):
	bullets = bullet_manager


func _spawn_bullet_at(spawn_point) -> void:
	spawn_point.spawn(firing_entity)


func fire(firing_actor) -> void:
	is_firing = true
	firing_entity = firing_actor


func stop() -> void:
	is_firing = false
	firing_entity = Enums.Actor.Environment
