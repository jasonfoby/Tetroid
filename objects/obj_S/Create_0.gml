event_inherited();
color = make_color_rgb(0, 255, 255); // 시안 색상
shape = [
    [0, 1, 1],
    [1, 1, 0]
];

rotate = function() {
    rotation = (rotation + 1) % 2;
    if (rotation == 0) {
        shape = [[0, 1, 1], 
				 [1, 1, 0]];
    } else {
        shape = [[1, 0], 
				 [1, 1], 
				 [0, 1]];
    }
}