show_debug_message("Draw event start: obj_grid exists: " + string(instance_exists(obj_grid)));
if (instance_exists(obj_grid)) {
    show_debug_message("obj_grid cell_size: " + string(obj_grid.cell_size));
}

var cell_size;
var grid_x, grid_y;
if (variable_instance_exists(id, "grid_instance") && instance_exists(grid_instance)) {
    cell_size = grid_instance.cell_size;
    grid_x = grid_instance.grid_x;
    grid_y = grid_instance.grid_y;
} else {
    cell_size = 32; // 기본값 설정
    grid_x = 0;
    grid_y = 0;
    show_debug_message("Warning: Using default values. obj_grid might not exist.");
}

var preview_x = room_width - 100;
var preview_y = 50;
draw_set_font(fnt_score);
draw_set_color(c_white);
draw_text(preview_x, preview_y - 30, "Next:");

if (instance_exists(next_tetromino)) {
    with (next_tetromino) {
        var block_color = variable_instance_exists(id, "color") ? color : c_white;
        for (var i = 0; i < array_length(shape); i++) {
            for (var j = 0; j < array_length(shape[i]); j++) {
                if (shape[i][j] != 0) {
                    draw_rectangle_color(
                        preview_x + j * cell_size,
                        preview_y + i * cell_size,
                        preview_x + (j + 1) * cell_size,
                        preview_y + (i + 1) * cell_size,
                        block_color, block_color, block_color, block_color, false
                    );
                }
            }
        }
    }
}

// 활성 테트로미노 그리기
if (instance_exists(active_tetromino)) {
    with (active_tetromino) {
        for (var i = 0; i < array_length(shape); i++) {
            for (var j = 0; j < array_length(shape[i]); j++) {
                if (shape[i][j] != 0) {
                    var draw_x = obj_tetromino.grid_x + (grid_x + j) * obj_tetromino.cell_size;
                    var draw_y = obj_tetromino.grid_y + (grid_y + i) * obj_tetromino.cell_size;
                    draw_rectangle_color(draw_x, draw_y, draw_x + obj_tetromino.cell_size, draw_y + obj_tetromino.cell_size, color, color, color, color, false);
                }
            }
        }
    }
}

// 게임 오버 화면
if (game_over) {
    draw_set_alpha(0.5);
    draw_rectangle_color(0, 0, room_width, room_height, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_gameover);
    draw_set_color(c_red);
    draw_text(room_width / 2, room_height / 2, "GAME OVER");
    draw_set_font(fnt_score);
    draw_set_color(c_white);
    draw_text(room_width / 2, room_height / 2 + 40, "Final Score: " + string(score));
    draw_text(room_width / 2, room_height / 2 + 70, "Press R to Restart");
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}


// obj_game_controller의 Draw 이벤트
if (instance_exists(next_tetromino)) {
    show_debug_message("Next tetromino type: " + object_get_name(next_tetromino.object_index));
    show_debug_message("Next tetromino color exists: " + string(variable_instance_exists(next_tetromino, "color")));
} else {
    show_debug_message("Next tetromino does not exist");
}