// 그리드 크기 설정
grid_width = 10;
grid_height = 20;
cell_size = 48; // 픽셀 단위

// 그리드 초기화
grid = ds_grid_create(grid_width, grid_height);
ds_grid_clear(grid, 0);

// 그리드 위치 설정
grid_x = (room_width - (grid_width * cell_size)) / 2;
grid_y = room_height - (grid_height * cell_size);