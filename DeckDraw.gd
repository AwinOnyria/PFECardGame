extends TextureButton

var ButtonSize = Vector2(250, 350)
var DeckSize = INF

# Called when the node enters the scene tree for the first time.
func _ready():
	scale *= ButtonSize/size


func _gui_input(event):
	if Input.is_action_just_released("leftclick"):
		if DeckSize > 0:
			DeckSize = $"../..".DrawCard()
			if DeckSize < 1:
				disabled = true
