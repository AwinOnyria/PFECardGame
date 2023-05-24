extends CanvasLayer


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
		title.text = "YOU WIN!"
		title.modulate = Color.GREEN
	else:
		title.text = "YOU LOSE"
		title.modulate = Color.RED

func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://play_space.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
