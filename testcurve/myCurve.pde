void myCurve(int n, float len, int rot) {
    
    if (n == 0) {
        
        l(len);
        rotate(PI/2 * rot);
        l(len);
        l(len);
        rotate(-PI/2 * rot);
        l(len);
        
    } else {
        
        myCurve(n-1, len, -rot);
        if (n % 2 == 0) rotate(PI/2 * rot);
        myCurve(n-1, len, rot);
        myCurve(n-1, len, rot);
        if (n % 2 == 0) rotate(-PI/2 * rot);
        myCurve(n-1, len, -rot);
        
    }
    
}

void myCurve2(int n, float d, int rot) {
    
    float len = 0.5 * sqrt(pow(d,2) / 2);
    //println("N = " + n + ", len = " + len);
    
    if (n == 0) {
        
        l(len);
        rotate(PI/2 * rot);
        l(len);
        l(len);
        rotate(-PI/2 * rot);
        l(len);
        
    } else {
    
        myCurve2(n-1, len, -rot);
        if (n % 2 == 0) rotate(PI/2 * rot);
        myCurve2(n-1, len, rot);
        myCurve2(n-1, len, rot);
        if (n % 2 == 0) rotate(-PI/2 * rot);
        myCurve2(n-1, len, -rot);
    }
}
