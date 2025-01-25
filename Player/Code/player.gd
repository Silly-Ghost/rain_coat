extends CharacterBody2D

@onready var conversation_handler: Node2D = $"Hud/Conversation Handler"
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

var speed:int = 37
var last_input_vector:Vector2 = Vector2.ZERO
var curr_animation_state:String = "IDLE"
var last_animation_state:String = "IDLE"
var waiting_on_animation:String = ""

var state = PLAYER
@export var is_set_chat:bool = false

enum {
	PLAYER,
	CHAT,}

signal pass_camera(char)
signal on_char_reached_loaction()
signal event_finished()
signal event(char_num:int, cords:Vector2, speed:int)
signal event_anim(char_num:int, anim:String)

func _ready() -> void:
	state = CHAT if is_set_chat else PLAYER

func _physics_process(delta: float) -> void:
	match state:
		PLAYER:
			handel_movement(delta)
			handel_animation()
		CHAT:
			handel_animation()

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


func play_convo(convo, sound):
	set_player_state()
	conversation_handler.play_convo(convo, sound)

func set_player_state():
	curr_animation_state = "IDLE"
	velocity = Vector2.ZERO
	state = CHAT

func move_char(char_num, cords, temp_speed):
	event.emit(char_num, cords, temp_speed)

func play_anim(temp_char, anim):
	event_anim.emit(temp_char, anim)

func continue_convo():
	conversation_handler.curr_convo += 1
	conversation_handler.continue_convo()

func end_event():
	event_finished.emit()
	Data.save_game()
	state = PLAYER

func on_play_anim(anim):
	state = CHAT
	animation_state.travel(anim)

func play_aniamtion(anim):
	state = CHAT
	waiting_on_animation = anim
	animation_state.travel(anim)

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == waiting_on_animation:
		animation_state.travel("IDLE")
		waiting_on_animation = ""
		on_char_reached_loaction.emit()

func pass_camera_to_char(char_num):
	pass_camera.emit(char_num)


func _on_test_map_change_player_pos(cords: Variant) -> void:
	position = cords
