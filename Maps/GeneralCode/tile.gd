extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

var can_hit:bool = true

func set_timer(time):
	timer.wait_time = time
	timer.start()

func _on_timer_timeout() -> void:
	show()
	animation_player.play("Fly")


func _on_player_detector_body_entered(body: Node2D) -> void:
	if can_hit:
		can_hit = false
		get_parent().get_parent().get_parent().bullet_conected()
		body._on_hit(2)


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
