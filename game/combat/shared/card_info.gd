class_name CardInfo
extends Resource

export(String) var name
export(String) var description
export(Enums.CardType) var type
export(float) var play_interval


func get_card_id():
	var split_path = resource_path.split(".tres")[0].split("/")
	return split_path[split_path.size() - 1]
