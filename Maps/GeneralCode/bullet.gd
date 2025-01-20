extends CharacterBody2D

var dir:float
var speed = 150
var canHit = true

func _physics_process(_delta):
	velocity = Vector2(0, -speed).rotated(dir)
	move_and_slide()

	if global_position.x < 0 or global_position.x > 480 or global_position.y < 0 or global_position.y > 270:
		queue_free()

func _on_player_detected(body: Node2D) -> void:
	if canHit:
		canHit = false
		visible = false
		get_parent().get_parent().bullet_conected()
		$hit.play()
		body._on_hit(5)

func _on_hit_finished() -> void:
	queue_free()
