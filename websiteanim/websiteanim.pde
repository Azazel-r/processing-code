//
//
//

int numFrames = 200;
Ball[] bs1;
color[] brighter = new color[] {#151719, #284770, #4374A1, #42AED6, #1BE3C3};
color[] darker   = new color[] {#09090A, #16273D, #2E4F6E, #3384A3, #15B097};

boolean SAVE = true;
String SAVEAS = ".gif";

void setup() {
    size(450,1080);
    bs1 = new Ball[] {new Ball(200, brighter[0], darker[0]),
                      new Ball(200, brighter[1], darker[1]),
                      new Ball(200, brighter[2], darker[2]),
                      new Ball(200, brighter[3], darker[3]),
                      new Ball(200, brighter[4], darker[4]) };
}

void draw() {
    
    background(#1f1e33);
    float t = 1.0 * (frameCount-1) / numFrames % 1;
    float r = 200;
    
    translate(100,height);
    drawChain(bs1, r, t, -1);
    
    translate(250,-height);
    drawChain(bs1, r, t, 1);
    
    if (SAVE && frameCount <= numFrames) saveFrame("frames\\frame###" + SAVEAS);
    
}

void drawChain(Ball[] b, float r, float t, int down) {
    
    push();
    
    float off = map(t, 0, 1, 0, height);
    float margin = (height - (r*b.length))/b.length;
    println(margin);
    
    translate(0, -1 * down * off);
    for (int i = 0; i < b.length * 2; ++i) {
        translate(0, down * r/2);
        b[i % b.length].drawMe();
        translate(0, down * r/2 + down * margin);
    }
    
    pop();
    
}

class Ball {
    
    float r;
    color c1, c2;
    PShape inner = null;
    float strokerad = 8;
    
    Ball(float tr, color tc1, color tc2) {
        c1 = tc1;
        c2 = tc2;
        r = tr;
    }
    
    void setInner(PShape s) {
        inner = s;
    }
    
    void drawMe() {
        push();
        stroke(c2);
        strokeWeight(strokerad);
        fill(c1);
        circle(0,0,r-strokerad);
        if (inner != null) shape(inner, 0, 0);
        pop();
    }
    
    
}
