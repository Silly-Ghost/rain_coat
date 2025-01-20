extends CharacterBody2D

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

var speed:int = 37
var last_input_vector:Vector2 = Vector2.ZERO
var curr_animation_state:String = "IDLE"
var last_animation_state:String = "IDLE"

var state = PLAYER
enum {
	PLAYER,
	CHAT,}

func _physics_process(delta: float) -> void:
	match state:
		PLAYER:
			handel_movement(delta)
			handel_animation()
		CHAT:
			pass # load chat menu in future

func handel_animation():
	animation_tree.set("parameters/" + curr_animation_state + "/blend_position", last_input_vector)

	if last_animation_state != curr_animation_state:
		last_animation_state = curr_animation_state
		animation_state.travel(curr_animation_state)

func handel_movement(delta):
	var input_vector = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up"),)

	if input_vector!= Vector2.ZERO:
		curr_animation_state = "WALK"
		velocity = input_vector.normalized() * (speed * 100) * delta
		last_input_vector = input_vector
		move_and_slide()
		return

	curr_animation_state = "IDLE"
