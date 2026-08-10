extends Control

@onready var resume: Button = %Resume
@onready var restart: Button = %Restart
@onready var back_to_menu: Button = %BackToMenu
@onready var exit: Button = %Exit
@onready var sfxclic: AudioStreamPlayer = $Sfxclic

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		get_tree().paused = not get_tree().paused
		visible = get_tree().paused

func _ready() -> void:
	hide()
	resume.pressed.connect(_on_resume_pressed)
	restart.pressed.connect(_on_restart_pressed)
	back_to_menu.pressed.connect(_on_back_to_menu_pressed)
	exit.pressed.connect(_on_exit_pressed)
	
func _on_resume_pressed() -> void:
	sfxclic.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().paused = false
	hide()

func _on_restart_pressed() -> void:
	sfxclic.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _on_back_to_menu_pressed() -> void:
	sfxclic.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
func _on_exit_pressed() -> void:
	sfxclic.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().quit()
