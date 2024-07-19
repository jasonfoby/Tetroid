// 테트로미노 공통 속성
cell_size = 48;
grid_x = 0;
grid_y = 0;

color = make_color_rgb(255, 255, 255); // 흰색 (기본 색상)

// 테트로미노 모양 (자식 오브젝트에서 오버라이드됨)
shape = [];

// 회전 상태
rotation = 0;

// 이동 및 회전 메서드
move_left = function() {
    grid_x -= 1;
}

move_right = function() {
    grid_x += 1;
}

move_up = function() {
    grid_y -= 1;
}

move_down = function() {
    grid_y += 1;
}

rotate = function() {
    rotation = (rotation + 1) % 4;
    // 구체적인 회전 로직은 자식 오브젝트에서 구현
}