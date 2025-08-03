extends Node

@export var menu_scene: PackedScene
@export var planning_scene: PackedScene
@export var game_scene: PackedScene
@export var loading_scene: PackedScene

var target_scene: PackedScene

func change_scene_inst(scene: PackedScene) -> void:
	get_tree().call_deferred("change_scene_to_packed", scene)

func change_scene(scene: PackedScene) -> void:
	target_scene = scene
	
	var current_scene = get_tree().current_scene
	var loading_scene_instance = loading_scene.instantiate()
	
	# Adding scene and removing previous one rather than
	# changing immediately prevents brief screen flicker
	get_tree().root.add_child(loading_scene_instance)
	get_tree().current_scene = loading_scene_instance
	current_scene.queue_free()
	
