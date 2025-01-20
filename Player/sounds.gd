extends Node2D

@onready var step: AudioStreamPlayer = $Step


func foot_step():
	step.pitch_scale = randf_range(0.95, 1.05)
	step.play()
