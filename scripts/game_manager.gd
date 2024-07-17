extends Node2D

func _ready():
	if OS.has_feature("dedicated_server"):
		print("starting dedicated server...")
		MultiplayerManager.become_host()

func become_host():
	print ("Become host pressed")
	%MultiplayerHUD.hide()
	MultiplayerManager.become_host()

func join_as_player_2():
	print("Join as Player 2")
	%MultiplayerHUD.hide()
	MultiplayerManager.join_as_player_2()
