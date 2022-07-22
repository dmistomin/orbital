class_name CardTile
extends Control

export(String) var current_size = "small"
export(bool) var is_reload_card
export(bool) var is_resolving_effect

export(Vector2) var huge_size = Vector2(256, 256)
export(Vector2) var large_size = Vector2(192, 192)
export(Vector2) var mid_size = Vector2(128, 128)
export(Vector2) var small_size = Vector2(64, 64)

var linked_card
var _time


func _process(delta):
	if is_resolving_effect:
		_time += delta
		_update_radial_frame()


func _resize_value_num_if_exists():
	if !is_reload_card:
		$HugeValueLabel.visible = current_size == "huge"
		$BigValueLabel.visible = current_size == "large"
		$MidValueLabel.visible = current_size == "medium"
		$SmallValueLabel.visible = current_size == "small"


func _update_radial_frame():
	$RadialFrame.value = _time

	if _time >= $RadialFrame.max_value:
		_time = 0.0
		$RadialFrame.value = 0.0
		$RadialFrame.visible = false
		is_resolving_effect = false


func setup(card = null):
	linked_card = card

	if card != null:
		card.linked_tile = self

	draw()


func play():
	is_resolving_effect = true
	_time = 0.0

	$RadialFrame.visible = true
	$RadialFrame.tint_under = Color.gray
	if linked_card.owner == Enums.Actor.PLAYER:
		$RadialFrame.tint_progress = Color.aqua
	else:
		$RadialFrame.tint_progress = Color.red
	$RadialFrame.step = 0.001
	$RadialFrame.max_value = linked_card.play_interval


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
		$Frame.self_modulate = Color.white
		return

	$Frame.self_modulate = Color.darkgray
