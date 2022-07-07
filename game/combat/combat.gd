class_name Combat
extends Node

onready var bullets = $Bullets
onready var hud = $HUD
onready var level = $Level
onready var player = $Player
onready var player_ship = $Player/Ship


func setup() -> void:
	for pattern in player_ship.get_node("BulletPatterns").get_children():
		pattern.bullets = bullets

	player.connect("on_hand_reloaded", hud, "reload_hand")


func start(deck) -> void:
	level.spawn_player_ship(player_ship)
	player.start_game(deck)
	player.reload_hand()
