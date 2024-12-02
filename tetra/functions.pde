void drawShape(int n, float t2) {
    
    push();
    
    int[][] mygrid;
    color mycol;
    t2 = period(t2);
    
    switch (n) {
        
        case 0:
            mygrid = grid_O;
            mycol = color(255,255,0);
            break;
        case 1:
            mygrid = grid_I;
            mycol = color(0,255,255);
            break;
        case 2:
            mygrid = grid_T;
            mycol = color(255,0,255);
            break;
        case 3:
            mygrid = grid_S;
            mycol = color(0,255,0);
            break;
        case 4:
            mygrid = grid_Z;
            mycol = color(255,0,0);
            break;
        case 5:
            mygrid = grid_L;
            mycol = color(255,128,0);
            break;
        case 6:
            mygrid = grid_J;
            mycol = color(0,0,255);
            break;
        default:
            mygrid = new int[][] {{1}};
            mycol = 255;
    }
    
    int x = mygrid[0].length;
    int y = mygrid.length;
    translate(width/2, height/2);
    for (int j = 0; j < y; ++j) {
        for (int i = 0; i < x; ++i) {
            if (mygrid[j][i] == 1) {
                float maxX = map(i, 0, x, -x * rad / 2, x * rad / 2);
                float maxY = map(j, 0, y, -y * rad / 2, y * rad / 2);
                drawTile(map(t2, 0, 1, -0.5 * rad, maxX), map(t2, 0, 1, -0.5 * rad, maxY), lerpColor(color(128,128,128), mycol, t2));
            }
        }
    }
    
    pop();
    
}

void drawTile(float x, float y, color col) {
    push();
    stroke(0);
    strokeWeight(10);
    fill(col);
    square(x,y,rad);
    pop();
}

float period(float t2) {
    float p1 = 0.33;
    float p2 = 0.66;
    // return -0.5 * cos(TWO_PI*t) + 0.5;
    if      (t2 < p1) return -0.5 * cos(PI * map(t2, 0, p1, 0, 1)) + 0.5;
    else if (t2 > p2) return  0.5 * cos(PI * map(t2, p2, 1, 0, 1)) + 0.5;
    else return 1;
}
