if (!game_over) {
    // 터치 입력 처리
    if (device_mouse_check_button_pressed(0, mb_left)) {
        var touch_x = device_mouse_x(0);
        var touch_y = device_mouse_y(0);
        
        if (position_meeting(touch_x, touch_y, left_button)) {
            with (active_tetromino) {
                move_left();
                if (other.check_collision(id)) move_right();
            }
        }
        else if (position_meeting(touch_x, touch_y, right_button)) {
            with (active_tetromino) {
                move_right();
                if (other.check_collision(id)) move_left();
            }
        }
        else if (position_meeting(touch_x, touch_y, down_button)) {
            with (active_tetromino) {
                move_down();
                if (other.check_collision(id)) {
                    move_up();
                    other.lock_tetromino();
                }
            }
        }
        else if (position_meeting(touch_x, touch_y, rotate_button)) {
            with (active_tetromino) {
                rotate();
                if (other.check_collision(id)) rotate_back();
            }
        }
    }
    
    // 테트로미노 자동 낙하
    if (current_time - last_fall_time >= 1000 / fall_speed) {
        with (active_tetromino) {
            move_down();
            if (other.check_collision(id)) {
                move_up();
                other.lock_tetromino();
            }
        }
        last_fall_time = current_time;
    }
}