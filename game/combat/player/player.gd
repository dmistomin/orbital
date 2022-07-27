class_name Player
extends Node

signal on_card_played(card)
signal on_death
signal on_health_changed(prev_health, new_health, max_health)
signal on_hand_reloaded(deck, hand)
signal on_hand_empty(deck, hand)
signal on_stagger_changed(prev_stagger, new_stagger, max_stagger)
signal on_lock_on_changed(prev_target, new_target)

export(int) var hand_size
export(int) var health
export(int) var stagger
export(int) var max_health
export(int) var max_stagger
export(Enums.LockOnType) var lock_on_setting

var lock_on_target

var deck
var discard
var hand


func _process(_delta: float):
	if lock_on_setting == Enums.LockOnType.CLOSEST_ABOVE_CENTER:
		_locate_closest_center_target()


func _locate_closest_center_target():
	var enemies = get_tree().get_nodes_in_group("enemy")

	var current_target
	var target_origin = $Ship.global_position + Vector2(0, -25)

	if (
		lock_on_target != null
		and is_instance_valid(lock_on_target)
		and lock_on_target.global_position.y > target_origin.y
	):
		lock_on_target.toggle_lock_on(false)
		lock_on_target = null

	for e in enemies:
		if e.global_position.y > target_origin.y:
			continue

		if current_target == null:
			current_target = e

		var distance_to_current_target = current_target.global_position.distance_to(target_origin)
		var distance_to_new_target = e.global_position.distance_to(target_origin)

		var new_target_is_above_ship = target_origin.y > e.global_position.y

		if distance_to_new_target < distance_to_current_target and (new_target_is_above_ship):
			current_target = e

	if lock_on_target != current_target:
		emit_signal("on_lock_on_changed", lock_on_target, current_target)

		if lock_on_target != null and is_instance_valid(lock_on_target):
			lock_on_target.toggle_lock_on(false)

		if current_target != null and is_instance_valid(current_target):
			current_target.toggle_lock_on(true)

		lock_on_target = current_target


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
