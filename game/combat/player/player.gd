class_name Player
extends Node

signal on_card_played(card)
signal on_death
signal on_health_changed(prev_health, new_health, max_health)
signal on_hand_reloaded(deck, hand)
signal on_hand_empty(deck, hand)
signal on_stagger_changed(prev_stagger, new_stagger, max_stagger)

export(int) var hand_size
export(int) var health
export(int) var stagger
export(int) var max_health
export(int) var max_stagger

var deck
var discard
var hand


func start_game(player_deck) -> void:
	deck = player_deck
	discard = CardList.new()
	hand = []


func reload_hand() -> void:
	if hand.size() > 0:
		discard.add_several_cards(hand)

	if deck.count() == 0:
		deck.add_several_cards(discard.as_array())
		discard = CardList.new()
		deck.shuffle()

	hand = deck.draw(hand_size)
	emit_signal("on_hand_reloaded", deck, hand)


func play_card(card) -> void:
	card.effect.trigger()
	hand.erase(card)
	discard.add_one_card(card)
	emit_signal("on_card_played", card)

	if hand.size() == 0:
		emit_signal("on_hand_empty", deck, hand)
