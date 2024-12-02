// NIX WICHTIGES
// WOLLTE ES NUR NICHT VERLIEREN


        /*
        for (int i = 0; i < Cs.length; i++) {
            Cs[i].update(t);
        }
        */
        
        
                /*
                float insideVal = 0;
                for (int k = 0; k < Cs.length; k++) {
                    float temp = Cs[k].getInsideValue(x,y);
                    if (temp > insideVal) insideVal = temp;
                }
                */
                
/*

//                                a1         a2         b1          b2          radius
    Cs = new myCircle[] {new myCircle(rad,       width-rad, rad,        rad,        rad),
                         new myCircle(width-rad, rad,       height-rad, height-rad, rad),
                         new myCircle(rad,       rad,       height-rad, rad,        rad),
                         new myCircle(width-rad, width-rad, rad,        height-rad, rad)};

class myCircle {
    
    float x, y;
    float a1, b1, a2, b2;
    float radius;
    
    myCircle(float ta1, float ta2, float tb1, float tb2, float trad) {
        x = ta1;
        y = tb1;
        a1 = ta1;
        b1 = tb1;
        a2 = ta2;
        b2 = tb2;
        radius = trad;
    }
    
    void update(float t) {
        t = period(t);
        x = map(t, 0, 1, a1, a2);
        y = map(t, 0, 1, b1, b2);
    }
    
    void drawMe() {
        strokeWeight(radius*2);
        point(x,y);
    }
    
    float getInsideValue(float tx, float ty) {
        float distance = dist(x,y,tx,ty);
        if (distance > radius) return 0;
        return map(distance, radius, 0, 1, 0);
    }
    
}

*/
