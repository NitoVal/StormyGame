extends Control
@onready var optionsMenu = preload("res://pause_menu.gdshader")

func _ready():
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")

func testEsc():
	if Input.is_action_just_pressed("escape") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("escape") and get_tree().paused:
		resume()


func _on_resume_pressed():
	resume()
	print("Resume pressed")

func _on_restart_pressed() -> void:
	pass # Replace with function body.
	print("Restart pressed")

func _on_quit_pressed():
	get_tree().quit()
	print("Quit pressed")
