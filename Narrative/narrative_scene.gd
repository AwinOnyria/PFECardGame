extends CanvasLayer

var event_tag = "event0.0"
@onready var narrative_scene = preload("res://Narrative/narrative_scene.tscn")
@onready var narrative_button = preload("res://Narrative/narrative_button.tscn")


func _ready():
	var file = FileAccess.open("res://Story/test.json", FileAccess.READ)
	var json_object = JSON.new()
	var parse_err = json_object.parse(file.get_as_text())
	var data = json_object.get_data()[event_tag]
	$Background/Columns/Rows/Core/CoreText.text = data[0]
	for tag in data[1].keys():
		var new_button = narrative_button.instantiate()
		new_button.button_tag = tag
		new_button.button_text = data[1][tag]
		$Background/Columns/Rows/ButtonContainer/Buttons.add_child(new_button)

func handle_button_pressed(button_tag):
	$"..".change_event(button_tag)
