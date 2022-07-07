class_name HUD
extends Node

signal on_card_played(card)

onready var player_hand = $LeftPanel/PlayerHand


func reload_hand(_deck, hand) -> void:
	player_hand.reload(hand)
