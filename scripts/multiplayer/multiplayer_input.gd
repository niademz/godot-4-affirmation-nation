extends MultiplayerSynchronizer

var input_direction = "none"
# Called when the node enters the scene tree for the first time.
func _ready():
	
	if get_multiplayer_authority() != multiplayer.get_unique_id():
		set_process(false)
		set_physics_process(false)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if Input.is_action_pressed("ui_right"):
		input_direction = "right"
	elif Input.is_action_pressed("ui_left"):
		input_direction = "left"
	elif Input.is_action_pressed("ui_up"):
		input_direction = "up"
	elif Input.is_action_pressed("ui_down"):
		input_direction = "down"
	else:
		input_direction = "none"


func _process(delta):
	pass
