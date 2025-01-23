extends CharacterBody2D

@export var speed:int = 25

var move_to_lcaotion:Vector2 = Vector2.ZERO
var last_derection:Vector2 = Vector2.ZERO

var sound = preload("res://Sounds/type Wrath.ogg")

@onready var dialogue: Node = $dialogue
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

signal on_char_reached_loaction()

func get_dialogue(key) -> Dictionary:
	return dialogue.dialogue[key]

func move_to_location(lcoation, temp_speed):
	speed = temp_speed
	move_to_lcaotion = lcoation
	animation_state.travel("WALK")


func _physics_process(delta: float) -> void:
	if move_to_lcaotion != Vector2.ZERO:

		var direction = move_to_lcaotion - position
		direction = direction.normalized()
		velocity = direction * (speed * 100) * delta
		last_derection = direction
		animation_tree.set("parameters/WALK/blend_position", last_derection)
		move_and_slide()

		if position.distance_to(move_to_lcaotion) <= 4:
			animation_tree.set("parameters/IDLE/blend_position", last_derection)
			animation_state.travel("IDLE")
			move_to_lcaotion = Vector2.ZERO
			emit_signal("on_char_reached_loaction")
