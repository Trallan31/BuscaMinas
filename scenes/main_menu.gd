extends Control

@onready var start: Button = %Start
@onready var exit: Button = %Exit
@onready var sfx_clic: AudioStreamPlayer = $SfxClic
@onready var credits: Button = %Credits

func _ready() -> void:
	start.pressed.connect(_on_start_pressed)
	credits.pressed.connect(_on_credits_pressed)
	exit.pressed.connect(_on_exit_pressed)
	
func _on_start_pressed() -> void:
	sfx_clic.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://scenes/board.tscn")
	
func _on_credits_pressed() -> void:
	sfx_clic.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
	
func _on_exit_pressed() -> void:
	sfx_clic.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().quit()
