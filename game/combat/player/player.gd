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
var hand


func start_game(player_deck) -> void:
	deck = player_deck
	hand = []


func reload_hand() -> void:
	hand = deck.draw(hand_size)
	emit_signal("on_hand_reloaded", deck, hand)


func play_card(card) -> void:
	hand.erase(card)
	emit_signal("on_card_played", card)

	if hand.count() == 0:
		emit_signal("on_hand_empty", deck, hand)
