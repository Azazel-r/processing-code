OpenSimplexNoise noise;
PFont myFont;
int numFrames = 300;
boolean SAVE = false;
boolean LOOP = true;
color BG = 0;
color COL1 = color(200, 100);
Letterthing[] l;
String density;
float MIN, MAX;
float diff = 0.05;
int N = 500;
boolean drawTwoTimes = false;
float z = 3000;

void setup() {
    size(1000,1000,P3D);
    textAlign(CENTER, CENTER);
    
    density = "abcdefghijklmnopqrstuvwxyz0123456789";
    MIN = 1.0*width/25;
    MAX = 4.0*width/5;
    noise = new OpenSimplexNoise(123);
    myFont = createFont("Webdings", 64);
    l = new Letterthing[N];
    for (int i = 0; i < l.length; ++i) {
        int mult = 0;
        float x = map((float) noise.eval(pow(10, ++mult), diff*i), -1, 1, -MAX, MAX);
        float y = map((float) noise.eval(pow(10, ++mult), diff*i), -1, 1, -MAX, MAX);
        if (-MIN <= y && y <= MIN) {
            if (x > 0) x = constrain(x, MIN, MAX);
            else x = constrain(x, -MAX, -MIN);
        }
        if (-MIN <= x && x <= MIN) {
            if (y > 0) y = constrain(y, MIN, MAX);
            else y = constrain(y, -MAX, -MIN);
        }
        float off = map((float) noise.eval(pow(10, ++mult), diff*i), -1, 1, 0, 1.5);
        String letter = String.valueOf(density.charAt(int(map((float) noise.eval(pow(10, ++mult), diff*i), -1, 1, 0, density.length()-1))));
        color c = color(map((float) noise.eval(pow(10, ++mult), diff*i), -1, 1, 0, 255),
                        map((float) noise.eval(pow(10, ++mult), diff*i), -1, 1, 0, 255),
                        map((float) noise.eval(pow(10, ++mult), diff*i), -1, 1, 0, 255),
                        200);
        
        
        l[i] = new Letterthing(x,y,-z,z,off,letter,c);
    }
}

void draw() {
    
    if (LOOP || frameCount <= numFrames) {
        
        background(BG);
        float t = 1.0 * (frameCount-1) / numFrames % 1;
        
        translate(width/2, height/2);
        //rotateZ(radians(map(t, 0, 1, 0, 360)));
        for (int i = 0; i < l.length; ++i) {
            l[i].drawMe(t);
        }
        if (SAVE) saveFrame("frame###.gif");
    }
}

class Letterthing {
    
    float x, y, startz, endz, off;
    String letter;
    color c;
    boolean twoTimes;
    
    Letterthing(float tx, float ty, float tstartz, float tendz, float toff, String tletter, color tc) {
        x = tx;
        y = ty;
        startz = tstartz;
        endz = tendz;
        off = toff;
        letter = tletter;
        c = tc;
    }
    
    void drawMe(float p) {
        push();
        fill(c);
        float z = map((p+off)%1, 0, 1, startz, endz);
        float z2 = endz-startz;
        translate(x,y,z);
        textFont(myFont);
        text(letter, 0, 0);
        if (drawTwoTimes) {
            translate(0,0,-z2);
            text(letter, 0, 0);
        }
        pop();
    }
    
}
