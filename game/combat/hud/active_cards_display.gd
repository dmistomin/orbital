class_name ActiveCardsDisplay
extends HBoxContainer

signal on_player_action_free
signal on_enemy_action_free

var _player_tile: CardTile
var _enemy_tile: CardTile


func display_player_action(tile) -> void:
	assert(_player_tile == null)

	_player_tile = tile
	_player_tile.set_tile_size("medium")
	_player_tile.toggle_border_highlight(false)
	add_child(_player_tile)
	move_child(_player_tile, 0)
	_player_tile.visible = true
	yield(get_tree().create_timer(_player_tile.linked_card.play_interval), "timeout")
	remove_child(_player_tile)
	_player_tile = null
	tile.queue_free()
	emit_signal("on_player_action_free")


func display_enemy_action(tile) -> void:
	assert(_enemy_tile == null)

	_enemy_tile = tile
	_enemy_tile.set_tile_size("medium")
	_enemy_tile.toggle_border_highlight(false)
	add_child(_enemy_tile)
	_enemy_tile.visible = true
	yield(get_tree().create_timer(_enemy_tile.linked_card.play_interval), "timeout")
	remove_child(_enemy_tile)
	_enemy_tile = null
	tile.queue_free()
	emit_signal("on_enemy_action_free")
