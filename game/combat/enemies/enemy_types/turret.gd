class_name Turret
extends Enemy

var _player_ship


func _process(_delta: float):
	if _player_ship:
		_look_at_player()


func _look_at_player():
	look_at(_player_ship.global_position)


func setup() -> void:
	.setup()
	_player_ship = get_tree().get_nodes_in_group("player_ship")[0]


func fire() -> void:
	var bullet_manager = get_tree().get_nodes_in_group("bullet_manager")[0]
	var bullet = $Barrel/BulletSpawn.spawn(Enums.Actor.ENEMY)
	bullet_manager.add_child(bullet)
