extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_end_turn_pressed():
	$"..".end_turn() # Replace with function body.


func _on_discard_pressed():
	$"..".discard_hand() # Replace with function body.
