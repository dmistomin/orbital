class_name Combat
extends Node

onready var bullets = $Bullets
onready var level = $Level
onready var player = $Player
onready var player_ship = $Player/Ship


func start():
	bullets.setup()
	level.spawn_player_ship(player_ship)
