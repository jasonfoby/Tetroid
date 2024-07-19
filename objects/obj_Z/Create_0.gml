event_inherited();
color = make_color_rgb(255, 165, 0); // 주황색
shape = [
    [1, 1, 0],
    [0, 1, 1]
];

rotate = function() {
    rotation = (rotation + 1) % 2;
    if (rotation == 0) {
        shape = [[1, 1, 0], 
				 [0, 1, 1]];
    } else {
        shape = [[0, 1], 
				 [1, 1], 
				 [1, 0]];
    }
}