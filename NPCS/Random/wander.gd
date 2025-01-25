extends Node2D

@export var wonderRange = 64
 
@onready var startPostion = global_position
@onready var targetPostion = global_position
@onready var timer = $Timer


func targetpostion_update():
	var target_vector = Vector2(randf_range(-wonderRange, wonderRange), randf_range(-wonderRange, wonderRange))
	targetPostion = startPostion + target_vector


func _on_timer_timeout():
	targetpostion_update()


func set_timer(duration):
	timer.start(duration)


func get_time_left():
	return timer.time_left
