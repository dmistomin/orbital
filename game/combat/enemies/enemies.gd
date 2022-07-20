class_name Enemies
extends Node

var _is_active = false
var _current_idx = 0


func _process(_delta: float) -> void:
	if _is_active:
		var current_wave = $Waves.get_child(_current_idx)

		if not current_wave:
			print("all waves cleared!")
			_is_active = false
			return

		if not current_wave.is_active:
			print("starting wave #%s" % _current_idx)
			current_wave.start()

		if current_wave.has_been_cleared:
			print("wave #%s has been cleared!" % _current_idx)
			current_wave.is_active = false
			_current_idx += 1


func start_game() -> void:
	_is_active = true
