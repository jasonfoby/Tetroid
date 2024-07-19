// 게임 상태 변수
game_over = false;
score = 0;


fall_speed = 1; // 초당 한 칸씩 떨어짐
last_fall_time = current_time;

// 현재 활성 테트로미노
active_tetromino = noone;

// 다음 테트로미노
next_tetromino = noone;

// 테트로미노 타입 배열
tetromino_types = [obj_I, obj_J, obj_L, obj_O, obj_S, obj_T, obj_Z];


// 가상 버튼 생성
var button_size = 64;
var margin = 20;

left_button = instance_create_layer(margin, room_height - margin - button_size, "Instances", obj_virtual_button);
left_button.button_type = "left";
left_button.sprite_index = spr_left_arrow; // 적절한 스프라이트를 만들어 사용하세요

right_button = instance_create_layer(margin + button_size + 10, room_height - margin - button_size, "Instances", obj_virtual_button);
right_button.button_type = "right";
right_button.sprite_index = spr_right_arrow;

down_button = instance_create_layer(room_width - margin - button_size, room_height - margin - button_size, "Instances", obj_virtual_button);
down_button.button_type = "down";
down_button.sprite_index = spr_down_arrow;

rotate_button = instance_create_layer(room_width - margin - button_size, room_height - margin - 2*button_size - 10, "Instances", obj_virtual_button);
rotate_button.button_type = "rotate";
rotate_button.sprite_index = spr_rotate;


// 테트로미노 생성 함수
create_tetromino = function() {
    var type = tetromino_types[irandom(array_length(tetromino_types) - 1)];
    var tetromino = instance_create_layer(room_width / 2, 0, "Instances", type);
    tetromino.grid_x = floor(obj_grid.grid_width / 2) - 1;
    tetromino.grid_y = 0;
    return tetromino;
}

// 초기 테트로미노 생성
active_tetromino = create_tetromino();
next_tetromino = create_tetromino();
next_tetromino.visible = false;

lock_tetromino = function() {
    place_tetromino(active_tetromino);
    check_lines();
    
    // 새 테트로미노 생성
    instance_destroy(active_tetromino);
    active_tetromino = next_tetromino;
    active_tetromino.visible = true;
    active_tetromino.grid_x = floor(obj_grid.grid_width / 2) - 1;
    active_tetromino.grid_y = 0;
    
    next_tetromino = create_tetromino();
    next_tetromino.visible = false;
    
    // 게임 오버 검사
    if (check_collision(active_tetromino)) {
        game_over = true;
    }
}

// 충돌 검사 함수
check_collision = function(tetromino) {
    for (var i = 0; i < array_length(tetromino.shape); i++) {
        for (var j = 0; j < array_length(tetromino.shape[i]); j++) {
            if (tetromino.shape[i][j] != 0) {
                var check_x = tetromino.grid_x + j;
                var check_y = tetromino.grid_y + i;
                
                if (check_x < 0 || check_x >= obj_grid.grid_width || check_y >= obj_grid.grid_height) {
                    return true;  // 벽 또는 바닥과 충돌
                }
                
                if (check_y >= 0 && obj_grid.grid[# check_x, check_y] != 0) {
                    return true;  // 다른 블록과 충돌
                }
            }
        }
    }
    return false;
}

// 테트로미노 그리드에 배치
place_tetromino = function(tetromino) {
    for (var i = 0; i < array_length(tetromino.shape); i++) {
        for (var j = 0; j < array_length(tetromino.shape[i]); j++) {
            if (tetromino.shape[i][j] != 0) {
                var place_x = tetromino.grid_x + j;
                var place_y = tetromino.grid_y + i;
                
                if (place_y >= 0) {  // 화면 위쪽 경계 확인
                    obj_grid.grid[# place_x, place_y] = tetromino.color;
                }
            }
        }
    }
}

// 줄 제거 및 점수 계산
check_lines = function() {
    var lines_cleared = 0;
    
    for (var i = obj_grid.grid_height - 1; i >= 0; i--) {
        var line_full = true;
        for (var j = 0; j < obj_grid.grid_width; j++) {
            if (obj_grid.grid[# j, i] == 0) {
                line_full = false;
                break;
            }
        }
        
        if (line_full) {
            // 줄 제거
            for (var k = i; k > 0; k--) {
                for (var j = 0; j < obj_grid.grid_width; j++) {
                    obj_grid.grid[# j, k] = obj_grid.grid[# j, k - 1];
                }
            }
            // 최상단 줄 비우기
            for (var j = 0; j < obj_grid.grid_width; j++) {
                obj_grid.grid[# j, 0] = 0;
            }
            
            lines_cleared++;
            i++;  // 같은 줄을 다시 검사 (윗줄이 내려왔으므로)
        }
    }
    
    // 점수 계산 (예: 1줄 100점, 2줄 300점, 3줄 500점, 4줄 800점)
    switch (lines_cleared) {
        case 1: score += 100; break;
        case 2: score += 300; break;
        case 3: score += 500; break;
        case 4: score += 800; break;
    }
}


if (!instance_exists(obj_grid)) {
    show_debug_message("obj_grid does not exist. Creating one.");
    instance_create_layer(0, 0, "Instances", obj_grid);
}
grid_instance = instance_find(obj_grid, 0);