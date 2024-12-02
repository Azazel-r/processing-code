Sierpinski s;
boolean SAVE = true;
boolean LOOP = false;
int numFrames = 100;
int MIN = 580;
int MAX = MIN*2;
int deep = 7;

void setup() {
    size(1000,1000);
    s = new Sierpinski(0,0,MIN,deep);
}

void draw() {
    
    if (LOOP || frameCount <= numFrames) {
        
        float t = 1.0 * (frameCount-1)/numFrames % 1;
        float size = map(easeOutBounce(t), 0, 1, MIN, MAX);
        if (t < 0.25) s.setStuff(size, deep);
        else s.setStuff(size, deep+1);
        
        background(0);
        stroke(200);
        strokeWeight(1.4);
        translate(width/2,height/2);
        s.drawSierp(0);
        translate(-size, 0);
        s.drawSierp(0);
        rotate(radians(60));
        translate(size, 0);
        rotate(radians(-60));
        s.drawSierp(0);
        
        if (SAVE) saveFrame("frame###.gif");
        
    }
}

float period(float x) {
    float c4 = (2 * PI) / 3;

    return x == 0
    ? 0
    : x == 1
    ? 1
    : pow(2, -10 * x) * sin((x * 10 - 0.75) * c4) + 1;
}

float easeOutBounce(float x) {
    float n1 = 7.5625;
    float d1 = 2.75;

    if (x < 1 / d1) {
        return n1 * x * x;
    } else if (x < 2 / d1) {
        return n1 * (x -= 1.5 / d1) * x + 0.75;
    } else if (x < 2.5 / d1) {
        return n1 * (x -= 2.25 / d1) * x + 0.9375;
    } else {
        return n1 * (x -= 2.625 / d1) * x + 0.984375;
    }

}

class Sierpinski {
    
    float x, y, size, smallest;
    int N;
    
    Sierpinski(float tx, float ty, float tsize, int tN) {
        x = tx;
        y = ty;
        N = tN;
        size = tsize;
        smallest = size/pow(2, N);
    }
    
    void setStuff(float tsize, int tN) {
        size = tsize;
        N = tN;
        smallest = size/pow(2, N);
    }
    
    void drawSierp(int n) {
        
        if (n == 0) n = N;
        
        if (n == 1) {
            
            pushMatrix();
            triang();
            translate(smallest, 0);
            triang();
            rotate(radians(-120));
            translate(smallest, 0);
            rotate(radians(120));
            triang();
            popMatrix();
            return;
            
        }
        
        else {
            
            pushMatrix();
            float currentSize = size/pow(2, int(abs(n-N-1)));
            drawSierp(n-1);
            translate(currentSize, 0);
            drawSierp(n-1);
            rotate(radians(-120));
            translate(currentSize, 0);
            rotate(radians(120));
            drawSierp(n-1);
            popMatrix();
            return;
            
        }
        
    }
    
    void triang() {
        pushMatrix();
        line(0, 0, smallest, 0);
        translate(smallest, 0);
        rotate(radians(-120));
        line(0, 0, smallest, 0);
        translate(smallest, 0);
        rotate(radians(-120));
        line(0, 0, smallest, 0);
        popMatrix();
    }
    
}
