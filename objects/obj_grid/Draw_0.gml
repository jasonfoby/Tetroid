// obj_grid의 Draw 이벤트
if (!instance_exists(obj_grid)) {
    show_debug_message("obj_grid does not exist!");
    exit;
}
var cell_size = obj_grid.cell_size;

for (var i = 0; i < grid_width; i++) {
    for (var j = 0; j < grid_height; j++) {
        var xx = grid_x + (i * cell_size);
        var yy = grid_y + (j * cell_size);
        
        if (grid[# i, j] != 0) {
            // 채워진 셀
            draw_rectangle_color(xx, yy, xx + cell_size, yy + cell_size, grid[# i, j], grid[# i, j], grid[# i, j], grid[# i, j], false);
        }
        // 그리드 선
        draw_rectangle(xx, yy, xx + cell_size, yy + cell_size, true);
    }
}