extends MarginContainer

const BarBase = preload("res://GUI/bar.tscn")

@onready var conflict_database = preload("res://Gameplay/conflict_database.gd")
@onready var conflict_database_temp = conflict_database.new()
@onready var entity_database = preload("res://Gameplay/entity_database.gd")
@onready var entity_database_temp = entity_database.new()

var conflict_type = "ECONOMICAL_CONFLICT"
@onready var entity_info = entity_database_temp.DATA[entity_database_temp.get(conflict_type)]
@onready var conflict_info = conflict_database_temp.CONFLICT_DATA[conflict_database_temp.get(conflict_type)]
@onready var color_info = conflict_database_temp.COLOR_DATA[conflict_database_temp.get(conflict_type)]

var entity_name = ""
var image_path = "res://Assets/Art/Entities/"
var is_player = true
var entity_image_name = "placeholder.png"
var side_index = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	if entity_name in entity_info:
		entity_image_name = entity_name + ".png"
	image_path += entity_image_name
	$Organizer/Image/EntityImage.texture = load(image_path)
	$Organizer/Image/EntityImage.scale *= size / $Organizer/Image/EntityImage.texture.get_size()
	print(conflict_info)
	print(color_info)
	setup()


func setup():
	if is_player:
		side_index = 0
	
	if not conflict_info[2]:
		create_bar(0, conflict_info[3][side_index], 100, 100)
	
	for index in range(1, 3):
		if conflict_info[3 + index][side_index] == "NAB":
			pass
		else:
			create_bar(index, conflict_info[3 + index][side_index], 100, 100)

func create_bar(index, bar_name, max_value, start_value):
	var new_bar = BarBase.instantiate()
	new_bar.bar_name = bar_name
	new_bar.max_value = max_value
	new_bar.value = start_value
	new_bar.fill_color = color_info[index][0]
	new_bar.border_color = color_info[index][1]
	new_bar.change_color = color_info[index][2]
	new_bar.background_color = color_info[index][3]
	new_bar.setup()
	$Organizer/Bars.add_child(new_bar)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
