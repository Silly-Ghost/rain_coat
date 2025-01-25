extends Node2D


signal change_scene(scene, player_cords, color_num)

func _on_button_pressed(Type: Variant) -> void:
	match Type:
		"start":
			change_scene.emit("load scene", Vector2.ZERO, 0)
