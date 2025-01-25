extends Node2D

@export var lightFlickTimeMin: float = 0.2
@export var lightFlickTimeMax: float = 1.2
@export var lightOffTimeMin: float = 0.8
@export var lightOffTimeMax: float = 2.4
@export var lightRadius: float = 2
@export_range (0,1) var brightnes:float = 1

@onready var light: Marker2D = $Light
@onready var lightTimeer: Timer = $Timer

var isLightOn:bool = false

func _ready() -> void:
	light.radius = lightRadius
	light.brightnes = brightnes


func _on_timer_timeout() -> void:
	if isLightOn:
		turn_light_off()
		return

	turn_light_on()


func turn_light_on():
	isLightOn = true

	var time = randf_range(lightFlickTimeMin, lightFlickTimeMax)
	lightTimeer.start(time)
	light.isOn = isLightOn


func turn_light_off():
	isLightOn = false
	
	var time = randf_range(lightOffTimeMin, lightOffTimeMax)
	lightTimeer.start(time)
	light.isOn = isLightOn
