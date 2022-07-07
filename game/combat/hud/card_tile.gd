class_name CardTile
extends Control

export(String) var current_size = "small"
export(bool) var is_reload_card
export(Vector2) var huge_size = Vector2(256, 256)
export(Vector2) var mid_size = Vector2(128, 128)
export(Vector2) var small_size = Vector2(64, 64)

var linked_card


func _resize_value_num_if_exists():
	if !is_reload_card:
		$BigValueLabel.visible = current_size == "large"
		$MidValueLabel.visible = current_size == "medium"
		$SmallValueLabel.visible = current_size == "small"


func setup(card = null):
	linked_card = card
	draw()


func draw():
	$Frame.self_modulate = Color.darkgray
	$DarkBackground.visible = (linked_card.owner == Enums.Actor.PLAYER)
	$LightBackground.visible = (linked_card.owner == Enums.Actor.ENEMY)
	$Icon.texture = load("res://assets/cards/%s.png" % linked_card.data.get_card_id())
	$SmallValueLabel.bbcode_text = "[center][color=black]%s[/color][/center]" % linked_card.value
	$MidValueLabel.bbcode_text = "[center][color=black]%s[/color][/center]" % linked_card.value
	$BigValueLabel.bbcode_text = "[center][color=black]%s[/color][/center]" % linked_card.value


func set_tile_size(size: String):
	current_size = size

	match current_size:
		"small":
			rect_min_size = small_size
		"medium":
			rect_min_size = mid_size
		"large":
			rect_min_size = huge_size

	_resize_value_num_if_exists()
