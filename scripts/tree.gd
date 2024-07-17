extends CharacterBody2D

var health = 80
var player_inaxe_zone = false

func _physics_process(delta):
	deal_with_damage()

func tree():
	pass



func _on_tree_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inaxe_zone = true
		print("player")


func _on_tree_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inaxe_zone = false

func deal_with_damage():
	if player_inaxe_zone and Global.player_current_axe == true:
		if health > 0:
			$tree_cooldown.start()
			$AnimationPlayer.play("hurt")
			




func _on_tree_cooldown_timeout():
	$tree_cooldown.stop()
	health = health - 20
	print(health)
	if health <= 0:
		health = 0
		$AnimationPlayer.play("RESET")
		$AnimationPlayer.play("dead")
