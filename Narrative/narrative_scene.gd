extends CanvasLayer

var event_tag = "event0.0"
@onready var narrative_scene = preload("res://Narrative/narrative_scene.tscn")
@onready var narrative_button = preload("res://Narrative/narrative_button.tscn")

var deck_composition = {}

func _ready():
	var file = FileAccess.open("res://Story/test.json", FileAccess.READ)
	var json_object = JSON.new()
	var parse_err = json_object.parse(file.get_as_text())
	var event_data = json_object.get_data()["events"][event_tag]
	var text_data = json_object.get_data()["narrative"][event_tag]
	$Background/Columns/Rows/Core/CoreText.text = text_data[0]
	for tag in event_data[1].keys():
		var new_button = narrative_button.instantiate()
		new_button.button_tag = tag
		new_button.button_text = event_data[1][tag]
		$Background/Columns/Rows/ButtonContainer/Buttons.add_child(new_button)
	
	$Background/Columns/LeftContainer/Rows/DeckInfo.text = create_deck_table()

func handle_button_pressed(button_tag):
	$"..".change_event(button_tag)

func create_deck_table():
	for card_id in $"../".deck:
		deck_composition[card_id] = 0
	var deck_description = "[table=2]"
	for card_id in deck_composition.keys():
		deck_composition[card_id] = $"../".deck.count(card_id)
		deck_description += "[cell bg=#808080,#e5e4e2 border=#000000][color=goldenrod]" + card_id + "[/color][/cell]"
		deck_description += "[cell bg=#808080,#e5e4e2 border=#000000][color=black]" + str($"../".deck.count(card_id)) + "[/color][/cell]"
	deck_description += "[/table]"
	return deck_description
