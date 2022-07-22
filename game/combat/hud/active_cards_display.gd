class_name ActiveCardsDisplay
extends HBoxContainer

signal on_player_action_free
signal on_enemy_action_free

var CardTile = preload("res://game/combat/hud/CardTile.tscn")

onready var player_tile = $PlayerTile
onready var enemy_tile = $EnemyTile


func _display_versus_label_if_required() -> void:
	if player_tile.linked_card and enemy_tile.linked_card:
		$VsLabel.modulate.a = 1.0
	else:
		$VsLabel.modulate.a = 0.0


func setup():
	player_tile.modulate.a = 0.0
	enemy_tile.modulate.a = 0.0
	$VsLabel.modulate.a = 0.0


func display_player_action(tile) -> void:
	assert(player_tile.linked_card == null)

	player_tile.setup(tile.linked_card)
	player_tile.set_tile_size("medium")
	player_tile.toggle_border_highlight(false)
	player_tile.modulate.a = 1.0

	tile.queue_free()

	if enemy_tile.linked_card:
		if enemy_tile.linked_card.value < player_tile.linked_card.value:
			player_tile.set_tile_size("large")
			player_tile.toggle_border_highlight(true)

	_display_versus_label_if_required()
	yield(get_tree().create_timer(player_tile.linked_card.play_interval), "timeout")

	player_tile.linked_card = null
	player_tile.modulate.a = 0.0
	_display_versus_label_if_required()
	emit_signal("on_player_action_free")


func display_enemy_card(card) -> void:
	assert(enemy_tile.linked_card == null)

	enemy_tile.setup(card)
	enemy_tile.set_tile_size("medium")
	enemy_tile.toggle_border_highlight(false)
	enemy_tile.modulate.a = 1.0

	if player_tile.linked_card:
		if player_tile.linked_card.value < enemy_tile.linked_card.value:
			enemy_tile.set_tile_size("large")
			enemy_tile.toggle_border_highlight(true)

	_display_versus_label_if_required()
	yield(get_tree().create_timer(enemy_tile.linked_card.play_interval), "timeout")

	enemy_tile.linked_card = null
	enemy_tile.modulate.a = 0.0
	_display_versus_label_if_required()
	emit_signal("on_enemy_action_free")
