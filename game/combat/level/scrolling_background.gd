class_name ScrollingBackground
extends ParallaxBackground

export(bool) var on
export(Vector2) var camera_velocity := Vector2(0, 100)


func _process(delta: float) -> void:
	if on:
		var new_offset := get_scroll_offset() + camera_velocity * delta
		set_scroll_offset(new_offset)
