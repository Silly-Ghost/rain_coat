extends Area2D


signal change_scene(scene, player_cords, color_num)


func _on_body_entered(_body: Node2D) -> void:
	change_scene.emit("waiting place", Vector2(1063, 722), 0)
	$"../Player".set_player_state()
