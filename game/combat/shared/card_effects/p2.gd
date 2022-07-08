extends CardEffect


func trigger() -> void:
	quad_pattern.fire(Enums.Actor.PLAYER)
	yield(combat.get_tree().create_timer(linked_card.play_interval), "timeout")
	quad_pattern.stop()
