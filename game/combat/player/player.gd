class_name Player
extends Node

signal on_health_changed(prev_health, new_health, max_health)
signal on_stagger_changed(prev_stagger, new_stagger, max_stagger)
signal on_death

export(int) var max_health
export(int) var health
export(int) var max_stagger
export(int) var stagger
