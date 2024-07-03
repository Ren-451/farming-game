extends Node2D

@onready var tile_map : TileMap = $TileMap

var ground_layer = 1
var cliff_layer = 2
var elements_layer = 3
var can_plant_custom_data = "plantable_area"

func _ready():
	pass 


func _input(event):
	# planting seeds
	if Input.is_action_just_pressed("click"):
		
		var mouse_pos : Vector2 = get_global_mouse_position() # <- very accurate mouse position; per pixel
		#print("global mouse position: ", mouse_pos)
		
		var tile_map_pos : Vector2i = tile_map.local_to_map(mouse_pos) # per tile 
		#print("tile map position: ", tile_map_pos)
		
		var source_id = 4
		var atlas_coords : Vector2i = Vector2i( 1, 0 )
		
		var tile_data : TileData = tile_map.get_cell_tile_data(ground_layer, tile_map_pos)
		if tile_data:
			var can_place_seeds = tile_data.get_custom_data(can_plant_custom_data)
			if can_place_seeds:
				tile_map.set_cell(elements_layer, tile_map_pos, source_id, atlas_coords)
			else:
				print("can't plant here.")
		else:
			print("no tile data.")
