@tool
extends RichTextEffect
class_name RichTextBoxEffect

var bbcode := "box"

func _process_custom_fx(char_fx):
	
	char_fx.offset = Vector2(0, 100)
	
	char_fx.visible = false
	
	return true
