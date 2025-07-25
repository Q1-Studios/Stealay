extends Node2D

@export var camera_3d: Camera3D
@export var target: Node3D

func _process(_delta: float) -> void:
	position = camera_3d.unproject_position(target.position)
