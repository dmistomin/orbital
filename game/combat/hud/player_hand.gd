class_name PlayerHand
extends VBoxContainer

signal on_tile_played(tile)
signal on_reload_requested

export(bool) var can_play_cards

var CardTile = preload("res://game/combat/hud/CardTile.tscn")
var ReloadTile = preload("res://game/combat/hud/ReloadTile.tscn")
var _hand = []
var _focused_idx = 0


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("scroll_cards_next"):
		_focus_next()
	if Input.is_action_just_pressed("scroll_cards_prev"):
		_focus_prev()
	if Input.is_action_just_pressed("play_card"):
		_play_focused_tile()


func _add_reload_tile() -> void:
	var reload_tile = ReloadTile.instance()
	_hand.append(reload_tile)
	add_child(reload_tile)


func _clear() -> void:
	for c in _hand:
		c.queue_free()

	_hand = []


func _change_focus() -> void:
	for i in range(_hand.size()):
		if i == _focused_idx:
			_hand[i].set_tile_size("large")
			_hand[i].toggle_border_highlight(true)
		else:
			_hand[i].set_tile_size("medium")
			_hand[i].toggle_border_highlight(false)


func _focus_next() -> void:
	var next_idx = _focused_idx + 1

	if next_idx >= _hand.size():
		next_idx = 0

	_focused_idx = next_idx
	_change_focus()


func _focus_prev() -> void:
	var prev_idx = _focused_idx - 1

	if prev_idx < 0:
		prev_idx = _hand.size() - 1

	_focused_idx = prev_idx
	_change_focus()


func _play_focused_tile() -> void:
	if _hand.size() < 1:
		return

	if not can_play_cards:
		return

	var tile_to_play = _hand[_focused_idx]
	_hand.erase(tile_to_play)
	remove_child(tile_to_play)

	if tile_to_play.is_reload_card:
		emit_signal("on_reload_requested")
		return

	emit_signal("on_tile_played", tile_to_play)

	if _focused_idx > 0:
		_focused_idx -= 1

	can_play_cards = false
	_change_focus()


func enable() -> void:
	can_play_cards = true


func disable() -> void:
	can_play_cards = false


func reload(cards) -> void:
	_clear()

	for c in cards:
		var new_tile = CardTile.instance()
		new_tile.setup(c)
		_hand.append(new_tile)
		add_child(new_tile)

	_add_reload_tile()
	_focused_idx = 0
	_change_focus()
