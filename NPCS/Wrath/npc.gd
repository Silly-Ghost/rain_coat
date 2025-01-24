extends CharacterBody2D

@export var speed:int = 25

var move_to_lcaotion:Vector2 = Vector2.ZERO
@export var last_derection:Vector2 = Vector2.ZERO

@export var file_sound_path:String = "res://Sounds/type Wrath.ogg"
var sound
var is_anim_wait:String = ""

@onready var dialogue: Node = $dialogue
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

signal on_char_reached_loaction()

func _ready() -> void:
	sound = load(file_sound_path)


func get_dialogue(key) -> Dictionary:
	return dialogue.dialogue[key]

func move_to_location(lcoation, temp_speed):
	speed = temp_speed
	move_to_lcaotion = lcoation
	animation_state.travel("WALK")

func play_aniamtion(animation):
	is_anim_wait = animation
	animation_state.travel(animation)

func _physics_process(delta: float) -> void:
	if move_to_lcaotion != Vector2.ZERO:

		var direction = move_to_lcaotion - position
		direction = direction.normalized()
		velocity = direction * (speed * 100) * delta
		last_derection = direction
		animation_tree.set("parameters/WALK/blend_position", last_derection)
		move_and_slide()

		if position.distance_to(move_to_lcaotion) <= 4:
			animation_state.travel("IDLE")
			move_to_lcaotion = Vector2.ZERO
			emit_signal("on_char_reached_loaction")
	animation_tree.set("parameters/IDLE/blend_position", last_derection)


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	print(anim_name)
	if anim_name == is_anim_wait:
		emit_signal("on_char_reached_loaction")


func gone():
	last_derection = Vector2(0,1)
	position = Vector2(1014, 756)
