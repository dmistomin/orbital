class_name Combat
extends Node

onready var level = $Level
onready var player = $Player
onready var player_ship = $Player/Ship


func start():
	level.spawn_player_ship(player_ship)
