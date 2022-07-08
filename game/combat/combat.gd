class_name Combat
extends Node

onready var bullets = $Bullets
onready var hud = $HUD
onready var level = $Level
onready var player = $Player
onready var player_ship = $Player/Ship


func _link_card_effects(deck) -> void:
	for c in deck.as_array():
		var effect_file_path = "res://game/combat/shared/card_effects/%s.gd" % c.data.get_card_id()
		c.effect = load(effect_file_path).new()
		c.effect.setup(c, self)


func setup() -> void:
	for pattern in player_ship.get_node("BulletPatterns").get_children():
		pattern.bullets = bullets

	hud.setup(player)


func start(deck) -> void:
	_link_card_effects(deck)

	level.spawn_player_ship(player_ship)
	deck.shuffle()
	player.start_game(deck)
	player.reload_hand()
