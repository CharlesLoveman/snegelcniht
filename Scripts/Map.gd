class_name TileMapWrapper extends Node


func get_tile_data(world_position: Vector2, key: String) -> Variant:
	'''
	 * get the custom data from tile at a given position
	 * world_position - position in global coordinates
	 * key - name of custom data
	 * returns tile[key] if tile exists, null otherwise
	'''
	var tile_map: TileMap = $TileMap
	var tile_pos: Vector2i = tile_map.local_to_map(world_position)
	var layer: int = 0
	var source_id: int = tile_map.get_cell_source_id(layer, tile_pos, false)
	if source_id == -1:
		return null
	var source: TileSetAtlasSource = tile_map.tile_set.get_source(source_id)
	if source:
		var atlas_coords: Vector2i = tile_map.get_cell_atlas_coords(layer, tile_pos, false)
		var tile_data: TileData = source.get_tile_data(atlas_coords, 0)
		return tile_data.get_custom_data(key)
	return null

func hit_tile(world_position: Vector2, damage: float):
	var tile_map: TileMap = $TileMap
	var tile_pos: Vector2i = tile_map.local_to_map(world_position)
	var layer: int = 0
	var source_id: int = tile_map.get_cell_source_id(layer, tile_pos, false)
	var source: TileSetAtlasSource = tile_map.tile_set.get_source(source_id)
	if source:
		var atlas_coords: Vector2i = tile_map.get_cell_atlas_coords(layer, tile_pos, false)
		var tile_data: TileData = source.get_tile_data(atlas_coords, 0)
		if damage > tile_data.get_custom_data("Toughness"):
			tile_map.set_cells_terrain_connect(0, [tile_pos], 0, -1, false)
