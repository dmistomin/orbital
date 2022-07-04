class_name Level
extends Node


func spawn_player_ship(ship: Ship) -> void:
	ship.position = $PlayerSpawn.position
	ship.visible = true
	ship.can_move = true
