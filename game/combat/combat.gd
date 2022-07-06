class_name Combat
extends Node

onready var bullets = $Bullets
onready var level = $Level
onready var player = $Player
onready var player_ship = $Player/Ship


func start():
	level.spawn_player_ship(player_ship)

	for pattern in player_ship.get_node("BulletPatterns").get_children():
		pattern.bullets = bullets
