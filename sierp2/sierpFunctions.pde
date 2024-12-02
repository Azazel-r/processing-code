void tri(float d, int dir) { // d = length of side; dir = direction of drawing (1 to the right, -1 to the left)
    pushMatrix();
    for (int i = 0; i < 3; ++i) {
        line(0,0,dir * d,0);
        translate(dir * d,0);
        rotate(radians(dir * -120));
    }
    popMatrix();
}

void sierpinskiTri(float d, int n, int dir) { // d = length of side; n = recurions; dir = direction of drawing (1 to the right, -1 to the left)
    
    if (n == 0) tri(d, dir);
    
    else {
        pushMatrix();
        
        sierpinskiTri(d/2, n-1, dir);
        translate(dir * d/2,0);
        sierpinskiTri(d/2, n-1, dir);
        rotate(radians(dir * -120));
        translate(dir * d/2,0);
        rotate(radians(dir * 120));
        sierpinskiTri(d/2, n-1, dir);
        
        popMatrix();
    }
    
}

float[] getSierpPos(float x, float y, float d, int n) {
    
    if (n == 0) return new float[] {x,y};
    
    float[] erg = new float[2 * (int) pow(3,n)];
    float x1 = x - d/2;
    float x2 = x + d/2;
    float x3 = x;
    float y1 = y + (d/2 * sqrt(3) - d*sin(PI/6)/sin(TWO_PI/3));
    float y2 = y1;
    float y3 = y - d*sin(PI/6)/sin(TWO_PI/3);
    
    float[] erg1 = getSierpPos(x1, y1, d/2, n-1);
    float[] erg2 = getSierpPos(x2, y2, d/2, n-1);
    float[] erg3 = getSierpPos(x3, y3, d/2, n-1);
    
    int index = 0;
    for (int i = 0; i < erg1.length / 2; ++i) {
        erg[index++] = erg1[2*i];
        erg[index++] = erg1[2*i+1];
        erg[index++] = erg2[2*i];
        erg[index++] = erg2[2*i+1];
        erg[index++] = erg3[2*i];
        erg[index++] = erg3[2*i+1];
    }
    return erg;
    
}

void newTri(float x, float y, float d, float n) {
    d = d / pow(2, n-1);
    float x1 = x - d/2;
    float x2 = x + d/2;
    float x3 = x;
    float y1 = y + (d/2 * sqrt(3) - d*sin(PI/6)/sin(TWO_PI/3));
    float y2 = y1;
    float y3 = y - d*sin(PI/6)/sin(TWO_PI/3);
    line(x1, y1, x2, y2);
    line(x2, y2, x3, y3);
    line(x3, y3, x1, y1);
}

float easeOutCubic(float p) {
    return 1 - pow(1 - p, 3);
}

float easeInCirc(float p) {
    return 1 - sqrt(1 - pow(p, 2));
}

float easeInOutCubic(float p) {
    return p < 0.5 ? 4 * p * p * p : 1 - pow(-2 * p + 2, 3) / 2;
}

float easeInCubic(float p) {
    return p * p * p;
}

float easeInExpo(float p) {
    return p == 0 ? 0 : pow(2, 10*p - 10);
}

float easeInSine(float p) {
    return 1 - cos(0.5 * PI * p);
}

float myCurve(float p) {
    return -0.5 * cos(TWO_PI * p) + 0.5;
}
