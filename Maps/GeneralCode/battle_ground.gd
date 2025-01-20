extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera_2d: Camera2D = $Camera2D

@export var random_shake_strenght: float = 7

@export var shakeFade:float = 5.0
@export var shakeStrenght: float = 0.0

var cameraShakeRNG = RandomNumberGenerator.new()

func _physics_process(delta: float) -> void:
	if shakeStrenght > 0:
		shakeStrenght = lerpf(shakeStrenght, 0, shakeFade * delta)
		camera_2d.offset = random_offset()

func _on_hit():
	animation_player.play("hit")

func bullet_conected():
	appaly_camera_shake(random_shake_strenght)

func appaly_camera_shake(strenght):
	shakeStrenght = strenght

func random_offset() -> Vector2:
	return Vector2(cameraShakeRNG.randf_range(-shakeStrenght, shakeStrenght), cameraShakeRNG.randf_range(-shakeStrenght, shakeStrenght))
