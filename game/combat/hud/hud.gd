class_name HUD
extends Node

signal on_card_played(card)

var player
onready var player_hand = $LeftPanel/PlayerHand
onready var active_cards_display = $RightPanel/ActiveCardsDisplay


func setup(p) -> void:
	player = p

	active_cards_display.connect("on_player_action_free", player_hand, "enable")
	active_cards_display.setup()

	player.connect("on_hand_reloaded", self, "reload_hand")
	player_hand.connect("on_reload_requested", player, "reload_hand")
	player_hand.connect("on_tile_played", active_cards_display, "display_player_action")
	player_hand.connect("on_tile_played", self, "resolve_tile_effects")

	player_hand.enable()


func resolve_tile_effects(played_tile) -> void:
	player.play_card(played_tile.linked_card)


func reload_hand(_deck, hand) -> void:
	player_hand.reload(hand)
