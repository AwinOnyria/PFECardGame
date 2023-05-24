extends TextureButton

var ButtonSize = Vector2(250, 350)

# Called when the node enters the scene tree for the first time.
func _ready():
	scale *= ButtonSize/size

