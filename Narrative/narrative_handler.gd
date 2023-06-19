extends Node

var initial_event_tag = "event0.0"
@onready var narrative_scene = preload("res://Narrative/narrative_scene.tscn")
@onready var conflict_scene = preload("res://play_space.tscn")
const deck_data = preload("res://Gameplay/Player_Hand.gd")
var deck = deck_data.Deck.duplicate()
var conflict_end_events = ["", ""]

func _ready():
	change_event(initial_event_tag)

func change_event(new_event_tag):
	var file = FileAccess.open("res://Story/test.json", FileAccess.READ)
	var json_object = JSON.new()
	var parse_err = json_object.parse(file.get_as_text())
	var event_data = json_object.get_data()["events"][new_event_tag]
	if event_data[0] == "narrative":
		var new_scene = narrative_scene.instantiate()
		new_scene.event_tag = new_event_tag
		add_child(new_scene)
	if event_data[0] == "conflict":
		var new_scene = conflict_scene.instantiate()
		new_scene.event_tag = new_event_tag
		conflict_end_events[0] = event_data[1].keys()[0]
		conflict_end_events[1] = event_data[1].keys()[1]
		new_scene.DeckSize = deck.size()
		new_scene.Deck = deck.duplicate()
		add_child(new_scene)
	get_child(0).queue_free()

func handle_conflict_win():
	change_event(conflict_end_events[1])

func handle_conflict_loss():
	change_event(conflict_end_events[0])
	
