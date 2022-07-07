class_name PlayerHand
extends VBoxContainer

var CardTile = preload("res://game/combat/hud/CardTile.tscn")
var ReloadTile = preload("res://game/combat/hud/ReloadTile.tscn")
var _hand = []
var _focused_idx = 0


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("scroll_cards_next"):
		_focus_next()
	if Input.is_action_just_pressed("scroll_cards_prev"):
		_focus_prev()


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
		else:
			if (i == _focused_idx + 1) or (i == _focused_idx - 1):
				_hand[i].set_tile_size("medium")
			else:
				_hand[i].set_tile_size("small")


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
