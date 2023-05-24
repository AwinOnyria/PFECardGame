extends Button

var button_text = ""
var button_tag = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	text = button_text # Replace with function body.


func _on_pressed():
	$"../../../../../..".handle_button_pressed(button_tag)
