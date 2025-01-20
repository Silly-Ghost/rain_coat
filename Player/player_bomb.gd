extends CharacterBody2D

@onready var health_bar: TextureProgressBar = $hud/helth_bar

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var speed:int = 65
var can_be_hit:bool = true

var state = PLAYER
enum {
	PLAYER,}

func _ready() -> void:
	Data.hp = Data.max_hp

func _physics_process(delta: float) -> void:
	match state:
		PLAYER:
			handel_movement(delta)

func handel_movement(delta):
	var input_vector = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up"),)

	if input_vector!= Vector2.ZERO:
		velocity = input_vector.normalized() * (speed * 100) * delta
		move_and_slide()
		return


func _on_hit(damage):
	if can_be_hit:
		get_parent()._on_hit()
		can_be_hit = false
		Data.hp -= damage
		health_bar.value = Data.hp
		$"AnimationPlayer/Hit chime".play()
		animation_player.play("Hit")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	can_be_hit = true
