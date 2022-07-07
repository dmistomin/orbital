class_name Inventory
extends Node

var CardInfoP1 = preload("res://data/cards/player/p1.tres")
var deck


func setup():
	var placeholder_deck = [
		Card.new(Enums.Actor.PLAYER, 1, CardInfoP1, CardEffect.new()),
		Card.new(Enums.Actor.PLAYER, 2, CardInfoP1, CardEffect.new()),
		Card.new(Enums.Actor.PLAYER, 3, CardInfoP1, CardEffect.new()),
		Card.new(Enums.Actor.PLAYER, 4, CardInfoP1, CardEffect.new()),
		Card.new(Enums.Actor.PLAYER, 5, CardInfoP1, CardEffect.new()),
		Card.new(Enums.Actor.PLAYER, 6, CardInfoP1, CardEffect.new()),
		Card.new(Enums.Actor.PLAYER, 7, CardInfoP1, CardEffect.new()),
		Card.new(Enums.Actor.PLAYER, 8, CardInfoP1, CardEffect.new()),
		Card.new(Enums.Actor.PLAYER, 9, CardInfoP1, CardEffect.new()),
	]

	deck = CardList.new()
	deck.add_several_cards(placeholder_deck)
