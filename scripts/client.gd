extends Control
class_name NakamaMultiplayer

var session : NakamaSession #this is session
var client : NakamaClient # this is client {session}
var socket : NakamaSocket #connection to Nakama

# Called when the node enters the scene tree for the first time.
func _ready():
	client = Nakama.create_client("defaultkey", "127.0.0.1", 7350, "http")
	
	pass # Replace with function body.

func updateUserInfo(username, displayname, avatarurl = "", language = "en", location = "us", timezone = "est"):
	await client.update_account_async(session,username, displayname, avatarurl, language, location, timezone)
	
func onMatchPresence(presence : NakamaRTAPI.MatchPresenceEvent):
	print(presence)

func onMatchState(state : NakamaRTAPI.MatchData):
	print(state)


func onSocketConnected():
	print("Socket Connected")

func onSocketClosed():
	print("Socket Closed")

func onSocketReceivedError(error):
	print("Socket Error: " + str(error))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_login_button_button_down():
	session = await client.authenticate_email_async($Panel2/EmailInput.text, $Panel2/PasswordInput.text)
	
	socket = Nakama.create_socket_from(client)
	
	await socket.connect_async(session)
	
	socket.connected.connect(onSocketConnected)
	socket.closed.connect(onSocketClosed)
	socket.received_error.connect(onSocketReceivedError)
	
	socket.received_match_presence.connect(onMatchPresence)
	socket.received_match_state.connect(onMatchState)
	updateUserInfo("test","testdisplay")
	var account = await client.get_account_async(session)
	
	$Panel/UserAccountText.text = account.user.username
	$Panel/DisplayNameText.text = account.user.display_name
	print(account)
	pass # Replace with function body.


func _on_store_data_button_down():
	var saveGame = {
		"name" : "username",
		"items" : {
			"id" : 1,
			"name" : "heart",
			 "ammo" : 10
		},
		"level" : 10
	}
	
	var data = JSON.stringify(saveGame)
	var result = await client.write_storage_objects_async(session,[
		NakamaWriteStorageObject.new("saves", "savegame", 1, 1, data,"")
	] )
	
	
	if result.is_exception():
		print("error: " + str(result))
		return
	print("stored data successfuly")
	pass # Replace with function body.


func _on_get_data_button_down():
	var result = await client.read_storage_objects_async(session, [
		NakamaStorageObjectId.new("saves", "savegame", session.user_id)
	])
	
	if result.is_exception():
		print("error: " + str(result))
		return
	for i in result.objects:
		print(i.value)
	pass # Replace with function body.


func _on_list_data_button_down():
	var dataList = await client.list_storage_objects_async(session, "saves", session.user_id, 5)
	for i in dataList.objects:
		print(i)
	pass # Replace with function body.
