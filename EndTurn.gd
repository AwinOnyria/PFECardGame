extends TextureButton

var ButtonSize = Vector2(250, 100)

# Called when the node enters the scene tree for the first time.
func _ready():
	scale *= ButtonSize/size


func _gui_input(event):
	if Input.is_action_just_released("leftclick"):
		$"../..".end_turn()
