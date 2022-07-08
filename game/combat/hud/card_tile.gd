class_name CardTile
extends Control

export(String) var current_size = "small"
export(bool) var is_reload_card
export(Vector2) var huge_size = Vector2(256, 256)
export(Vector2) var large_size = Vector2(192, 192)
export(Vector2) var mid_size = Vector2(128, 128)
export(Vector2) var small_size = Vector2(64, 64)

var linked_card


func _resize_value_num_if_exists():
	if !is_reload_card:
		$HugeValueLabel.visible = current_size == "huge"
		$BigValueLabel.visible = current_size == "large"
		$MidValueLabel.visible = current_size == "medium"
		$SmallValueLabel.visible = current_size == "small"


func setup(card = null):
	linked_card = card

	if card != null:
		card.linked_tile = self

	draw()


func draw():
	$Frame.self_modulate = Color.darkgray
	$DarkBackground.visible = (linked_card.owner == Enums.Actor.PLAYER)
	$LightBackground.visible = (linked_card.owner == Enums.Actor.ENEMY)
	$Icon.texture = load("res://assets/cards/%s.png" % linked_card.data.get_card_id())
	var value_text = "[center][color=black]%s[/color][/center]" % linked_card.value
	$SmallValueLabel.bbcode_text = value_text
	$MidValueLabel.bbcode_text = value_text
	$BigValueLabel.bbcode_text = value_text
	$HugeValueLabel.bbcode_text = value_text


func set_tile_size(size: String):
	current_size = size

	match current_size:
		"small":
			rect_min_size = small_size
		"medium":
			rect_min_size = mid_size
		"large":
			rect_min_size = large_size
		"huge":
			rect_min_size = huge_size

	_resize_value_num_if_exists()


func toggle_border_highlight(on: bool) -> void:
	if on:
		$Frame.self_modulate = Color.aqua
		return

	$Frame.self_modulate = Color.darkgray
