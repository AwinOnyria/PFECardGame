extends CanvasLayer

signal player_win
signal player_loss

@onready var title = $PanelContainer/MarginContainer/Rows/Title
var has_won = true


func _process(_delta):
	if has_won and not $WinMusic.playing:
		$WinMusic.play()
		$Penguin.visible = true
		$AnimationPlayer.play("penguin_dance")
	elif not has_won and not $LoseMusic.playing:
		$LoseMusic.play()

func set_title():
	if has_won:
		title.text = "VICTOIRE !"
		title.modulate = Color.GREEN
	else:
		title.text = "DÉFAITE..."
		title.modulate = Color.RED




func _on_restart_button_pressed():
	get_tree().paused = false
	print("should not be here")
	get_tree().change_scene_to_file("res://play_space.tscn")


func _on_quit_button_pressed():
	get_tree().quit()


func _on_continue_button_pressed():
	get_tree().paused = false
	if has_won:
		get_tree().call_group("Handler", "handle_conflict_win")
	else:
		get_tree().call_group("Handler", "handle_conflict_loss")
