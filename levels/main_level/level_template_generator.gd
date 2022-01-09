extends Node

# Map for pixel color to tile indexes
const COLOR_TILE_MAP = {
    Color(0, 0, 0, 0): 0, # Transparent
    Color(0, 0, 0, 1): 1, # Black
    Color(1, 0, 0, 1): 2, # Red
    Color(1, 1, 0, 1): 3  # Yellow
}

func generate_level_template():
    var result = []
    var template_img = Image.new()
    template_img.load("res://levels/main_level/map_templates/template_1.png")
    template_img.lock()

    for x in template_img.get_width():
        result.append([])
        for y in template_img.get_height():
            var tile = COLOR_TILE_MAP[template_img.get_pixel(x, y)]

            result[x].append(tile)

    return result
