extends Node2D

const ATTACK_LOAD = "res://Attacks/"

@onready var next_attack: Timer = $"Battle Handaler/next attack"
@onready var battle_junk: Node2D = $"Battle Ground/Battle junk"

@export var battle_time = "songLenght"
@export var attacks:int = 3


func _on_next_attack_timeout() -> void:
	var attack = randi_range(1, attacks)
	var laod_attack = load(ATTACK_LOAD + str(attack) + ".tscn")
	battle_junk.add_child(laod_attack.instantiate())

	next_attack.wait_time = 6
	next_attack.start()
