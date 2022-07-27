extends CardEffect


func trigger() -> void:
	straight_pattern.interval_between_bullets = 0.033
	straight_pattern.fire(Enums.Actor.PLAYER)
	yield(combat.get_tree().create_timer(linked_card.play_interval), "timeout")
	straight_pattern.stop()
