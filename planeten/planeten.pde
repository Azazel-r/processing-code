// Autor: René Richter
// Datum: 04.05.2024
// Zweck: Planetenbahnen oder so

int numFrames = 300;
boolean SAVE = true;
String SAVEAS = ".png";

void setup() {
    size(800,800,P3D);
    ellipseMode(RADIUS);
}

void draw() {
    background(0);
    
    float t = 1.0*(frameCount-1) / numFrames % 1;
    
    float[] m = new float[] {width/2, height/2, 0};
    float[] a = new float[] {30,0,0};
    for (int i = 0; i < 3; ++i) {
        float r = 75*(i+1);
        color c;
        if (i == 0) { c = color(255,0,0); }
        else if (i == 1) { c = color(0,255,0); }
        else { c = color(0,0,255); }
        drawBahn(r, m, a);
        obj1(r, m, a, t, c);
    }
    
    if (SAVE && frameCount<=numFrames) saveFrame("frames\\frame###" + SAVEAS);
}

void drawBahn(float r, float[] m, float[] a) {
    push();
    rotateX(radians(a[0]));
    rotateY(radians(a[1]));
    rotateZ(radians(a[2]));
    translate(m[0], m[1], m[2]);
    stroke(255);
    noFill();
    ellipse(0,0,r,r);
    pop();
}

void obj1(float r, float[] m, float[] a, float t, color c) {
    push();
    float x = r *  sin(TWO_PI * t);
    float y = r * -cos(TWO_PI * t);
    rotateX(radians(a[0]));
    rotateY(radians(a[1]));
    rotateZ(radians(a[2]));
    translate(m[0], m[1], m[2]);
    translate(x,y);
    rotateX(radians(-a[0] - 30));
    rotateY(radians(-a[1]));
    rotateZ(radians(-a[2]));
    rotateY(-2 * TWO_PI * t);
    stroke(c);
    noFill();
    box(30);
    
    pop();
}
