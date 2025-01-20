extends CharacterBody2D

const BULLET = preload("res://Maps/Battle Stuff/bullet.tscn")

@onready var time_to_shoot_timer: Timer = $timetoshoot
@onready var timer: Timer = $Timer
@onready var shoot_sound: AudioStreamPlayer = $Shoot

@export var reset_time:float = 0.5
@export var time_to_shoot:float = 8

var can_shoot = true
var num_of_bullets:int = 0

func _ready() -> void:
	time_to_shoot_timer.wait_time = time_to_shoot
	time_to_shoot_timer.start()


func shoot():
	var bullet_load = BULLET.instantiate()
	get_parent().get_parent().add_child(bullet_load)
	bullet_load.dir = global_rotation
	bullet_load.global_position = global_position
	bullet_load.global_rotation = global_rotation
	bullet_load.velocity = Vector2(-1, 0)


func _on_timer_timeout() -> void:
	if can_shoot:
		shoot()
		timer.wait_time = reset_time
		timer.start()


func _on_timetoshoot_timeout() -> void:
	can_shoot = false
