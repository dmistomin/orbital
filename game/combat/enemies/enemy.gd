class_name Enemy
extends KinematicBody2D

signal on_death
signal on_health_changed(prev_health, new_health, max_health)

export(int) var health
export(int) var max_health

onready var waves = $Waves


func setup() -> void:
	health = max_health
