class_name CardEffect
extends Reference

var linked_card
var combat
# Bullet Patterns
var straight_pattern
var quad_pattern


func setup(card, combat_obj) -> void:
	linked_card = card
	combat = combat_obj

	var player_bullet_patterns = combat.get_node("Player/Ship/BulletPatterns")
	straight_pattern = player_bullet_patterns.get_node("StraightLinePattern")
	quad_pattern = player_bullet_patterns.get_node("QuadBurstPattern")


func trigger() -> void:
	printerr("Card effect not implemented!")
