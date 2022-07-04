class_name Ship
extends KinematicBody2D

export(bool) var can_move
export(int) var speed
export(Vector2) var velocity


func _physics_process(delta: float) -> void:
	if can_move:
		var base_velocity := Vector2()

		if Input.is_action_pressed("move_left"):
			base_velocity.x = -1
		if Input.is_action_pressed("move_right"):
			base_velocity.x = 1
		if Input.is_action_pressed("move_up"):
			base_velocity.y = -1
		if Input.is_action_pressed("move_down"):
			base_velocity.y = 1

		velocity = base_velocity

		if base_velocity != Vector2():
			velocity = base_velocity.normalized() * speed
			move_and_collide(velocity * delta)
