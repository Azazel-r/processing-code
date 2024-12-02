int numFrames = 240;
Scheibe[] s;
int steps = 15;
boolean SAVE = true;
boolean LOOP = false;

void setup() {
    size(500,500, P3D);
    s = new Scheibe[64];
    for (int i = 0; i < sqrt(s.length); i++) {
        for (int j = 0; j < sqrt(s.length); j++) {
            s[i*8 + j] = new Scheibe(map(j, 0, sqrt(s.length)-1, -steps*10, steps*10), map(i, 0, sqrt(s.length)-1, -steps*10, steps*10), 20, color(255,0,0));
        }
    }
    
}

void draw() {
    if (LOOP || frameCount <= numFrames) {
        float t = 1.0 * (frameCount-1) / numFrames % 1;
        background(255);
        translate(width/2, height/2, 0);
        rectMode(CENTER);
        for (int i = 0; i < s.length; i++) {
            s[i].update(t);
            s[i].drawMe();
        }
        if (SAVE) saveFrame("frame###.gif");
    }
}

float period(float p) {
    return map(-cos(TWO_PI * p), -1, 1, 0,1);
}

float offset(float x, float y) {
    return 0.0025 * dist(x,y,0,0);
}

class Scheibe {
    
    float x, y, size, rot;
    color c;
    
    Scheibe(float tx, float ty, float tsize, color tc) {
        x = tx;
        y = ty;
        size = tsize;
        c = tc;
        rot = 0;
    }
    
    void drawMe() {
        push();
        translate(x,y,0);
        rotateX(radians(rot));
        rotateY(radians(rot));
        stroke(0);
        strokeWeight(2);
        fill(c);
        rect(0,0,size,size);
        pop();
    }
    
    void update(float p) {
        rot += 720.0/numFrames * period(p - offset(x,y));
        rot %= 360;
    }
    
}
