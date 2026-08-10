extends Button

var has_mine = false
var revealed = false
var flagged = false
var neighbor_mines = 0
var grid_position: Vector2i
@onready var flag: AudioStreamPlayer = $Flag

signal tile_clicked(Tile)

func _ready() -> void:
	theme_type_variation = "NormalButton"
	
func _pressed() -> void:
	emit_signal("tile_clicked", self)

func _gui_input(event):
	if revealed: return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			flagged = !flagged
			update_visuals()

func update_visuals():
	if flagged:
		flag.play()
		theme_type_variation = "FlagButton"
	else:
		theme_type_variation = "NormalButton"
		
