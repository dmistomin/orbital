class_name Enemies
extends Node

signal on_card_played(card)

var CardInfoE1 = preload("res://data/cards/enemy/e1.tres")

var deck
var discard
var current_card

var _is_active = false
var _current_idx = 0


func _process(_delta: float) -> void:
	if _is_active:
		var current_wave = $Waves.get_child(_current_idx)

		if not current_wave:
			print("all waves cleared!")
			_is_active = false
			return

		if current_wave.is_active and current_card == null:
			play_random_card()

		if not current_wave.is_active:
			print("starting wave #%s" % _current_idx)
			current_wave.start()

		if current_wave.has_been_cleared:
			print("wave #%s has been cleared!" % _current_idx)
			current_wave.is_active = false
			_current_idx += 1


func _link_card_effects(deck) -> void:
	for c in deck.as_array():
		var effect_file_path = "res://game/combat/shared/card_effects/%s.gd" % c.data.get_card_id()
		c.effect = load(effect_file_path).new()
		c.effect.setup(c, get_parent())


func start_game() -> void:
	_is_active = true

	var enemy_deck = [
		Card.new(Enums.Actor.ENEMY, 1, CardInfoE1),
		Card.new(Enums.Actor.ENEMY, 2, CardInfoE1),
		Card.new(Enums.Actor.ENEMY, 3, CardInfoE1),
		Card.new(Enums.Actor.ENEMY, 4, CardInfoE1),
		Card.new(Enums.Actor.ENEMY, 5, CardInfoE1),
		Card.new(Enums.Actor.ENEMY, 6, CardInfoE1),
		Card.new(Enums.Actor.ENEMY, 7, CardInfoE1),
		Card.new(Enums.Actor.ENEMY, 8, CardInfoE1),
		Card.new(Enums.Actor.ENEMY, 9, CardInfoE1),
	]

	deck = CardList.new()
	deck.add_several_cards(enemy_deck)
	_link_card_effects(deck)
	deck.shuffle()
	discard = CardList.new()


func play_random_card() -> void:
	if deck.count() == 0:
		deck.add_several_cards(discard.as_array())
		discard = CardList.new()
		deck.shuffle()

	current_card = deck.draw_one()

	if current_card:
		current_card.effect.trigger()
		discard.add_one_card(current_card)
		emit_signal("on_card_played", current_card)
		yield(get_tree().create_timer(current_card.play_interval), "timeout")
		current_card = null
