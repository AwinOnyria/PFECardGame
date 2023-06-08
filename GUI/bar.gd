extends HBoxContainer

var CHANGETIME = .5
var fill_color = Color()
var background_color = Color()
var change_color = Color()
var border_color = Color()
var max_value = 0
var value = 0
var bar_name = ""
var left_to_right = true
var is_middle_bar = false
var icon_name = "market_influence_icon"

enum {
	STILL,
	INCREASING,
	DECREASING
}
var state = STILL
var t = 0
var setup_change = true
var old_value = 0

# Called when the node enters the scene tree for the first time.
func _ready():
#	setup()

	max_value = 100
	value = 100
	fill_color = Color(.8, .7, 0, 1)
	change_color = Color(1, 1, 0, 1)
	border_color = Color(1, 1, .8, 1)
	setup()
	
	pass

func setup():
	state = STILL
	
	$Bars/ProgressBar.size.y = max($Bars/ChangeBar.size.y, $Bars/ProgressBar.size.y)
	$Bars/ChangeBar.size.y = max($Bars/ChangeBar.size.y, $Bars/ProgressBar.size.y)
		
	$Bars/ProgressBar.max_value = max_value
	$Bars/ProgressBar.value = value
	var new_style_progress_fill = StyleBoxFlat.new()
	new_style_progress_fill.bg_color = fill_color
	new_style_progress_fill.border_color = border_color
	if left_to_right:
		new_style_progress_fill.border_width_left = 3
	else:
		new_style_progress_fill.border_width_right = 3
	new_style_progress_fill.border_width_bottom = 0
	new_style_progress_fill.border_width_top = 3
	$Bars/ProgressBar.add_theme_stylebox_override("fill", new_style_progress_fill)
	
	$Bars/ChangeBar.max_value = max_value
	$Bars/ChangeBar.value = value
	var new_style_change_fill = StyleBoxFlat.new()
	new_style_change_fill.bg_color = change_color
	new_style_change_fill.border_color = border_color
	if left_to_right:
		new_style_change_fill.border_width_left = 3
	else:
		new_style_change_fill.border_width_right = 3
	new_style_change_fill.border_width_bottom = 3
	new_style_change_fill.border_width_top = 3
	$Bars/ChangeBar.add_theme_stylebox_override("fill", new_style_change_fill)
	
	$LeftIcon.texture = load("res://Assets/Art/Icons/" + icon_name + ".png")
	$RightIcon.texture = load("res://Assets/Art/Icons/" + icon_name + ".png")
	
	if not left_to_right:
		$Bars/ChangeBar.fill_mode = 1
		$Bars/ProgressBar.fill_mode = 1
		$LeftIcon.visible = true
		$RightIcon.visible = false
		
	if is_middle_bar:
		$Bars/ChangeBar.visible = false
	
#	$Count/Backround.size.x = size.y
#	$Count/Backround.size.y = size.y

func update_animation(delta):
	match state:
		STILL:
			if not setup_change:
				setup_change = true
			else:
				pass
		INCREASING:
			if setup_change:
				$Bars/ChangeBar.value = value
				old_value = $Bars/ProgressBar.value
				setup_change = false
			if t <= 1:
				$Bars/ProgressBar.value = old_value * (1 - t) + value * t
				t += delta/CHANGETIME
			else:
				$Bars/ProgressBar.value = value
				state = STILL
				t = 0
		DECREASING:
			if setup_change:
				if not is_middle_bar:
					$Bars/ProgressBar.value = value
				old_value = $Bars/ChangeBar.value
				setup_change = false
			if t <= 1:
				if is_middle_bar:
					$Bars/ProgressBar.value = old_value * (1 - t) + value * t
				else:
					$Bars/ChangeBar.value = old_value * (1 - t) + value * t
				t += delta/CHANGETIME
			else:
				$Bars/ChangeBar.value = value
				if is_middle_bar:
					$Bars/ProgressBar.value = value
				state = STILL
				t = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_animation(delta)




func _on_progress_bar_mouse_entered():
	$Bars/ProgressBar.show_percentage = true


func _on_progress_bar_mouse_exited():
	$Bars/ProgressBar.show_percentage = false


func _on_bars_mouse_entered():
	print("HAAAAAAAAAAAAAA")


func _on_mouse_entered():
	print("BAAAAAAAAAAAAAA")
