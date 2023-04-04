extends HBoxContainer

var CHANGETIME = 2
var FrontColor = Color()
var BackgroundColor = Color()
var ChangeColor = Color()
var BorderColor = Color()
var MaxValue = 0
var Value = 0
var left_to_right = true

enum {
	Still,
	Increasing,
	Decreasing
}
var state = Still
var t = 0
var setup_change = true
var old_value = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	setup()
	
	MaxValue = 100
	Value = 50
	FrontColor = Color(.8, .7, 0, 1)
	ChangeColor = Color(1, 1, 0, 1)
	BorderColor = Color(1, 1, .8, 1)
	left_to_right = false
	setup()
#
	Value = 80
	state = Increasing
##	Value = 20
##	state = Decreasing
	
	pass

func setup():
	state = Still
	
	$Bars/ProgressBar.size.y = max($Bars/ChangeBar.size.y, $Bars/ProgressBar.size.y)
	$Bars/ChangeBar.size.y = max($Bars/ChangeBar.size.y, $Bars/ProgressBar.size.y)
	
	$Bars/ProgressBar.max_value = MaxValue
	$Bars/ProgressBar.value = Value
	var new_style_progress_fill = StyleBoxFlat.new()
	new_style_progress_fill.bg_color = FrontColor
	new_style_progress_fill.border_color = BorderColor
	if left_to_right:
		new_style_progress_fill.border_width_left = 3
	else:
		new_style_progress_fill.border_width_right = 3
	new_style_progress_fill.border_width_bottom = 0
	new_style_progress_fill.border_width_top = 3
	$Bars/ProgressBar.add_theme_stylebox_override("fill", new_style_progress_fill)
	
	$Bars/ChangeBar.max_value = MaxValue
	$Bars/ChangeBar.value = Value
	var new_style_change_fill = StyleBoxFlat.new()
	new_style_change_fill.bg_color = ChangeColor
	new_style_change_fill.border_color = BorderColor
	if left_to_right:
		new_style_change_fill.border_width_left = 3
	else:
		new_style_change_fill.border_width_right = 3
	new_style_change_fill.border_width_bottom = 3
	new_style_change_fill.border_width_top = 3
	$Bars/ChangeBar.add_theme_stylebox_override("fill", new_style_change_fill)
	
	if not left_to_right:
		$Bars/ChangeBar.fill_mode = 1
		$Bars/ProgressBar.fill_mode = 1

func _update_animation(delta):
	match state:
		Still:
			print("still")
		Increasing:
			print("hello")
			if setup_change:
				$Bars/ChangeBar.value = Value
				old_value = $Bars/ProgressBar.value
				setup_change = false
			if t <= 1:
				$Bars/ProgressBar.value = old_value * (1 - t) + Value * t
				t += delta/CHANGETIME
			else:
				$Bars/ProgressBar.value = Value
				state = Still
				t = 0
		Decreasing:
			if setup_change:
				$Bars/ProgressBar.value = Value
				old_value = $Bars/ChangeBar.value
				setup_change = false
			if t <= 1:
				$Bars/ChangeBar.value = old_value * (1 - t) + Value * t
				t += delta/CHANGETIME
			else:
				$Bars/ChangeBar.value = Value
				state = Still
				t = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		Still:
			print("still")
		Increasing:
			print("hello")
			if setup_change:
				$Bars/ChangeBar.value = Value
				old_value = $Bars/ProgressBar.value
				setup_change = false
			if t <= 1:
				$Bars/ProgressBar.value = old_value * (1 - t) + Value * t
				t += delta/CHANGETIME
			else:
				$Bars/ProgressBar.value = Value
				state = Still
				t = 0
		Decreasing:
			if setup_change:
				$Bars/ProgressBar.value = Value
				old_value = $Bars/ChangeBar.value
				setup_change = false
			if t <= 1:
				$Bars/ChangeBar.value = old_value * (1 - t) + Value * t
				t += delta/CHANGETIME
			else:
				$Bars/ChangeBar.value = Value
				state = Still
				t = 0
