void draw__(){
    
    push();
    background(0);
    stroke(255);
    float thresh = 0.8;
    
    // teil 1:
    if (t < thresh) {
        
        float t_ = map(t, 0, thresh, 0, 1);
        float x = map(easeOutCubic(t_), 0, 1, 750, 50);
        float d = 700 + t_ * 700;
        int n = 7;
        if (t_ > .5) n = 8;
        translate(x,750);
        translate(map(easeInExpo(t_), 0, 1, 0, -700), 0);
        rotate(radians(map(easeInSine(t_), 0, 1, 0, 120)));
        sierpinskiTri(d, n, -1);
        
    } else {
        
        float d = 700;
        int n = 7;
        float t_ = map(t, thresh, 1, 0, 1);
        // #1
        translate(750,750);
        sierpinskiTri(d, n, -1);
        // #2
        pushMatrix();
        translate(-700,0);
        translate(0, t_ * t_ * 250);
        sierpinskiTri(d, n, -1);
        popMatrix();
        // #3
        rotate(radians(60));
        translate(-700,0);
        rotate(radians(-60));
        translate(0, t_ * t_ * -250);
        sierpinskiTri(d, n, -1);
    }
    
    pop();
    
}
