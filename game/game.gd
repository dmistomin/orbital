class_name Game
extends Node


func _ready() -> void:
	$Inventory.setup()
	$Combat.setup()

	$Combat.start($Inventory.deck)
