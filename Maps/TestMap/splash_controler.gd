extends Node2D


signal change_scene(menu, player_cords, fade_color)

func _on_timer_timeout() -> void:
	emit_signal("change_scene", "menu", Vector2.ZERO, 1)


func _on_texture_button_pressed() -> void:
	$AnimationPlayer.play("Poke")
	
