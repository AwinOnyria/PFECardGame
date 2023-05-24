extends Node

var initial_event_tag = "event0.0"
@onready var narrative_scene = preload("res://Narrative/narrative_scene.tscn")

func _ready():
	pass

func change_event(new_event_tag):
	var new_scene = narrative_scene.instantiate()
	new_scene.event_tag = new_event_tag
	add_child(new_scene)
	get_child(0).queue_free()
