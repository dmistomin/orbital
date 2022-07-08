class_name Card
extends Reference

export(Enums.Actor) var owner
export(String) var card_name
export(String) var description
export(Enums.CardType) var type
export(float) var play_interval
export(int) var value

var data
var effect
var linked_tile


func _init(o, val, dat):
	owner = o
	value = val
	data = dat

	card_name = data.name
	description = data.description
	play_interval = data.play_interval
	type = data.type
