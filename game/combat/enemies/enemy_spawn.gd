class_name EnemySpawn
extends Node2D

export(float) var delay
export(float) var conveyor_speed
export(Enums.EnemySpawnType) var spawn_type
export(PackedScene) var enemy_to_spawn

var has_spawned = false
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


func spawn() -> void:
	enemy = enemy_to_spawn.instance()
	enemy.setup()
	add_child(enemy)
	has_spawned = true
