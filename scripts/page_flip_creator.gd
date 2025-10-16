extends Node2D

@export var viewport_feed: Viewport
@export var page_flip_scene: PackedScene

func _on_page_flip() -> void:
	var flip: PageFlip = page_flip_scene.instantiate()
	add_child(flip)
	
	flip.flip_page(viewport_feed.get_texture().get_image())
