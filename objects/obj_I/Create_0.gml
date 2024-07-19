event_inherited();
color = make_color_rgb(0, 0, 255); // 파란색
shape = [
    [1], [1], [1], [1]
];

rotate = function() {
    rotation = (rotation + 1) % 2;
    if (rotation == 0) {
        shape = [[1], [1], [1], [1]]
    } else {
        shape = [[1, 1, 1, 1]];
    }
}