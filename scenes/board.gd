extends Control

@export var mine_counts = 6
@onready var grid_container: GridContainer = $ScrollContainer/GridContainer
@onready var win: Label = $CanvasLayer/win
@onready var lost: Label = $CanvasLayer/lost
@onready var pause_menu: Control = $CanvasLayer/PauseMenu
@onready var spin_box_rows: SpinBox = $CanvasLayer/SpinBoxRows
@onready var spin_box_cols: SpinBox = $CanvasLayer/SpinBoxCols
@onready var restart_button: Button = $CanvasLayer/RestartButton
@onready var sfxtile: AudioStreamPlayer = $sfxtile
@onready var sfxexplosion: AudioStreamPlayer = $sfxexplosion
var tiles = []
var tiles_dict = {}
var columns: int = 6
var rows:int = 4

func _ready() -> void:
	win.visible = false
	lost.visible = false
	create_grid()
	place_mines()
	calculate_numbers()

func create_grid():
	tiles.clear()
	tiles_dict.clear()
	grid_container.columns = columns
	for j in range(rows):
		for i in range(columns):
			var tile = preload("res://scenes/tile.tscn").instantiate()
			var pos = Vector2i(i, j)
			tile.grid_position = pos
			tile.connect("tile_clicked", on_tile_clicked)
			grid_container.add_child(tile)
			tiles.append(tile)
			tiles_dict[pos] = tile
	
func place_mines():
	var placed = 0
	while placed < mine_counts:
		var index = randi() % tiles.size()
		if not tiles[index].has_mine:
			tiles[index].has_mine = true
			placed += 1

func calculate_numbers():
	for tile in tiles:
		if tile.has_mine:
			continue
		var count = 0
		for x in range(-1, 2):
			for y in range(-1, 2):
				if x == 0 and y == 0: continue
				var neighbor_pos = tile.grid_position + Vector2i(x, y)
				if tiles_dict.has(neighbor_pos):
					if tiles_dict[neighbor_pos].has_mine:
						count += 1
		tile.neighbor_mines = count

func on_tile_clicked(tile):
	if tile.revealed or tile.flagged:
		return
	tile.revealed = true
	if tile.has_mine:
		sfxexplosion.play()
		tile.theme_type_variation = "WrongButton"
		reveal_all_mines()
		lost.visible = true
		pause_menu.visible = true
	else:
		sfxtile.play()
		apply_tile_theme(tile)
		if tile.neighbor_mines == 0:
			reveal_empty_neighbors(tile)
		check_win()
		
func apply_tile_theme(tile):
	if tile.neighbor_mines == 0:
		tile.theme_type_variation = "EmptyButton"
	else:
		var themes = ["OneButton", "TwoButton", "ThreeButton", "FourButton", "FiveButton",\
		"SixButton", "SevenButton", "EightButton"]
		tile.theme_type_variation = themes[tile.neighbor_mines - 1]
			
func reveal_empty_neighbors(tile):
	for x in range(-1, 2):
		for y in range(-1, 2):
			if x == 0  and y == 0: continue
			var neighbor_pos = tile.grid_position + Vector2i(x, y)
			if tiles_dict.has(neighbor_pos):
				var neighbor = tiles_dict[neighbor_pos]
				if not neighbor.revealed and not neighbor.has_mine:
					neighbor.revealed = true
					apply_tile_theme(neighbor)
					if neighbor.neighbor_mines == 0:
						reveal_empty_neighbors(neighbor)

func reveal_all_mines():
	for t in tiles:
		if t.flagged:
			if not t.has_mine:
				t.theme_type_variation = "WrongBombButton"
			else:
				t.theme_type_variation = "FlagButton"
			continue
		if not t.revealed:
			t.revealed = true
			if t.has_mine:
				t.theme_type_variation = "BombButton"
			else:
				apply_tile_theme(t)
	
func check_win():
	var safe_tiles_hidden = 0
	for tile in tiles:
		if not tile.has_mine and not tile.revealed:
			safe_tiles_hidden += 1
	if safe_tiles_hidden == 0:
		win.visible = true
		pause_menu. visible = true
		
func _on_restart_button_pressed() -> void:
	rows = int(spin_box_rows.value)
	columns = int(spin_box_cols.value)
	var total_tiles = rows * columns
	mine_counts = int(total_tiles * 0.25)
	win.visible = false
	lost.visible = false
	get_tree().paused = false
	for child in grid_container.get_children():
		child.queue_free()
	tiles.clear()
	tiles_dict.clear()
	grid_container.columns = columns
	create_grid()
	place_mines()
	calculate_numbers()
