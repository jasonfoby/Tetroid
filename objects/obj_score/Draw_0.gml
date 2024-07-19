draw_set_font(fnt_score); // 적절한 폰트를 미리 생성해야 합니다
draw_set_color(c_white);
draw_text(10, 10, "Score: " + string(score));