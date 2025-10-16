extends Sprite2D
class_name PageFlip

@export var base_material: StandardMaterial3D
@export var mesh_to_flip: MeshInstance3D
@export var animation_player: AnimationPlayer


func _ready() -> void:
	show()

func flip_page(page_img: Image) -> void:
	# Duplicate material, otherwise all pages are affected
	var flip_material: StandardMaterial3D = base_material.duplicate()
	flip_material.albedo_texture = ImageTexture.create_from_image(page_img)
	mesh_to_flip.set_surface_override_material(0, flip_material)
	
	animation_player.play("deformflip")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "deformflip":
		queue_free()
