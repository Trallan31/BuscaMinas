extends Control

@onready var menu: Button = $Menu
@onready var sfx_clic: AudioStreamPlayer = $SfxClic

func _ready() -> void:
	menu.pressed.connect(_on_back_to_menu_pressed)
	
func _on_back_to_menu_pressed() -> void:
	sfx_clic.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
