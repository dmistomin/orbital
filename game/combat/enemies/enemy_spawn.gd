class_name EnemySpawn
extends Node2D

export(float) var delay
export(float) var conveyor_speed
export(Enums.EnemySpawnType) var spawn_type
export(PackedScene) var enemy_to_spawn
export(Vector2) var x_limits = Vector2(500, 1420)
export(Vector2) var y_limits = Vector2(0, 1080)

var has_spawned = false
var enemy_destroyed = false
var enemy_off_screen = false
var enemy


func _ready():
	$EditorIcon.visible = false


func _physics_process(delta: float) -> void:
	if not has_spawned or enemy == null:
		return

	var base_velocity := Vector2()

	match spawn_type:
		Enums.EnemySpawnType.CONVEYOR_NORTH:
			base_velocity.y = -1
		Enums.EnemySpawnType.CONVEYOR_EAST:
			base_velocity.x = 1
		Enums.EnemySpawnType.CONVEYOR_SOUTH:
			base_velocity.y = 1
		Enums.EnemySpawnType.CONVEYOR_WEST:
			base_velocity.x = -1

	if base_velocity != Vector2():
		enemy.move_and_collide((base_velocity.normalized() * conveyor_speed) * delta)

		var enemy_moved_off_screen = false

		match spawn_type:
			Enums.EnemySpawnType.CONVEYOR_NORTH:
				if enemy.global_position.y < y_limits[0]:
					enemy_moved_off_screen = true
			Enums.EnemySpawnType.CONVEYOR_EAST:
				if enemy.global_position.x > x_limits[1]:
					enemy_moved_off_screen = true
			Enums.EnemySpawnType.CONVEYOR_SOUTH:
				if enemy.global_position.y > y_limits[1]:
					enemy_moved_off_screen = true
			Enums.EnemySpawnType.CONVEYOR_WEST:
				if enemy.global_position.x < x_limits[0]:
					enemy_moved_off_screen = true

		if enemy_moved_off_screen:
			enemy.queue_free()
			enemy = null
			enemy_off_screen = true


func spawn() -> void:
	enemy = enemy_to_spawn.instance()
	enemy.setup()
	add_child(enemy)
	has_spawned = true
