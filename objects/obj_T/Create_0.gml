event_inherited();
color = make_color_rgb(255, 255, 0); // 노란색
shape = [
    [1, 1, 1],
    [0, 1, 0]
];

rotate = function() {
    rotation = (rotation + 1) % 4;
    switch(rotation) {
        case 0:
            shape = [[1, 1, 1], 
					 [0, 1, 0]];
            break;
        case 1:
            shape = [[0, 1], 
					 [1, 1], 
					 [0, 1]];
            break;
        case 2:
            shape = [[0, 1, 0], 
					 [1, 1, 1]];
            break;
        case 3:
            shape = [[1, 0], 
					 [1, 1], 
					 [1, 0]];
            break;
    }
}