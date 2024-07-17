extends CharacterBody2D

const speed = 100
var current_dir = "none"
var is_attacking = false
var tree_inaxe_range = false
var tree_axe_cooldown = false

func _ready():
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta):
	if not is_attacking:
		player_movement(delta)
	axe()
	

func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0

	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D

	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	elif dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	elif dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")
	elif dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")

func axe():
	var dir = current_dir
	var anim = $AnimatedSprite2D
	if Input.is_action_just_pressed("ui_select"):
		Global.player_current_axe = true
		is_attacking = true
		if dir == "right":
			anim.flip_h = false
			anim.play("side_axe")
		elif dir == "left":
			anim.flip_h = true
			anim.play("side_axe")
		elif dir == "down":
			anim.play("front_axe")
		elif dir == "up":
			anim.play("back_axe")
		$axe_cooldown.start()
		$deal_attack_timer.start()

func player():
	pass

func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	is_attacking = false
	play_anim(0)


func _on_player_hitbox_body_entered(body):
	if body.has_method("tree"):
		tree_inaxe_range = true
		print("tree")
		


func _on_player_hitbox_body_exited(body):
	if body.has_method("tree"):
		tree_inaxe_range = false


func _on_axe_cooldown_timeout():
	$axe_cooldown.stop()
	Global.player_current_axe = false
	 # Replace with function body.
