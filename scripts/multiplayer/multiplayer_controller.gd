extends CharacterBody2D

const speed = 100
var current_dir = "none"
var movement = 0

@export var player_id := 1:
	set(id):
		player_id = id
		%InputSynchronizer.set_multiplayer_authority(id)

func _ready():
	if multiplayer.get_unique_id() == player_id:
		$Camera2D.make_current()
		$AnimatedSprite2D.play("front_idle")
	else:
		$Camera2D.enabled = false

func _physics_process(delta):
	if multiplayer.is_server():
		player_movement(delta)
	
	if not multiplayer.is_server() || MultiplayerManager.host_mode_enabled:
		play_anim()

func player_movement(delta):
	current_dir = %InputSynchronizer.input_direction
	if current_dir == "right":
		movement = 1
		velocity.x = speed
		velocity.y = 0
	elif current_dir == "left":
		movement = 1
		velocity.x = -speed
		velocity.y = 0
	elif current_dir == "down":
		movement = 1
		velocity.x = 0
		velocity.y = speed
	elif current_dir == "up":
		movement = 1
		velocity.x = 0
		velocity.y = -speed
	else:
		movement = 0
		velocity.x = 0
		velocity.y = 0

	move_and_slide()


func play_anim():
	var anim = $AnimatedSprite2D
	
	if current_dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		else:
			anim.play("side_idle")
	elif current_dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		else:
			anim.play("side_idle")
	elif current_dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("front_walk")
		else:
			anim.play("front_idle")
	elif current_dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("back_walk")
		else:
			anim.play("back_idle")
