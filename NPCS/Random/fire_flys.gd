extends CharacterBody2D

@export var ACCELERATION = 200
@export var MAX_SPEED = 30
@export var FRICTION = 100

@onready var PDZ:Area2D = $PlayerDetector
@onready var wander_control:Node2D = $Wander
@onready var sprite: Sprite2D = $Sprite2D

var last_derection = Vector2.ZERO

enum {
	IDLE,
	FLEE,
	WANDER,
}
var state = IDLE


func _physics_process(delta):

	match state:
		IDLE:
			idle(delta)
			if wander_control.get_time_left() == 0:
				state = pick_state([IDLE, WANDER])
				wander_control.set_timer(randf_range(1,3))
		FLEE:
			flee(delta)
		WANDER:
			wander(delta)
			if wander_control.get_time_left() == 0:
				state = pick_state([IDLE, WANDER])
				wander_control.set_timer(randf_range(3,5))


	if velocity != Vector2.ZERO:
		if last_derection.x > 0:
			sprite.scale.x = -1
		else:
			sprite.scale.x = 1
	move_and_slide()


func idle(delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	if PDZ.can_see_player():
		state = FLEE
	if velocity == Vector2.ZERO:
		if last_derection.x > 0:
			sprite.scale.x = -1
		else:
			sprite.scale.x = 1


func pick_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()


func flee(delta):
	var player = PDZ.player
	if player != null:
		var derection = (global_position - player.global_position).normalized()
		last_derection = derection
		velocity = velocity.move_toward(derection * MAX_SPEED, ACCELERATION * delta)
	if PDZ.can_see_player() == false:
		state = IDLE


func wander(delta):
	if PDZ.can_see_player():
		state = FLEE
	var derection = global_position.direction_to(wander_control.targetPostion)
	last_derection = derection
	velocity = velocity.move_toward(derection * MAX_SPEED, ACCELERATION * delta)

	if global_position.distance_to(wander_control.targetPostion) <= 4:
		state = pick_state([IDLE, WANDER])
		wander_control.set_timer(randf_range(1,3))
