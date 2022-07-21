extends CardEffect


func trigger() -> void:
	var turrets = combat.get_tree().get_nodes_in_group("turret")

	for t in turrets:
		t.fire()
