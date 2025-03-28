// Autor: René Richter
// Datum: 05.04.2024
// Zweck: Simple Pogo Pokestop Animation

PShape outerdebris, bigdebris, smalldebris, outer, inner, half;
int numFrames = 240;
color blue = color(44,228,255);
color purple = color(241,131,255);
boolean SAVE = true;
String SAVEAS = ".png";
boolean LOOP = false;

void setup() {
    size(800,800, P3D);
    ellipseMode(RADIUS);
    outerdebris = give(370, 390, 30);
    outer = give(280,350,360);
    bigdebris = give(230,260,70);
    smalldebris = give(230,260,15);
    half = give(110,210,170);
    inner = createShape(ELLIPSE, 0, 0, 75, 75);
    setup_ascii();
}

void draw() {
    
    if (LOOP || frameCount <= numFrames) {
        
        float t = 1.0*(frameCount-1)/numFrames % 1;
        background(255);
        push();
        translate(width/2, height/2);
        color COL1;
        if (t < 0.1) COL1 = colorFunc(t);
        else if (0.1 <= t && t < 0.5) COL1 = purple;
        else COL1 = lerpColor(purple, blue, map(t, 0.5, 0.8, 0, 1));
        refresh(COL1);
        
        // spinning circle
        push();
        rotateY(radians(spin(t, 7)));
        inner.setFill(COL1);
        inner.setStroke(COL1);
        shape(inner,0,0);
        pop();
        
        // two half rings
        push();
        rotateZ(radians(-85));
        shape(half,0,0);
        rotateZ(radians(180));
        shape(half,0,0);
        pop();
        
        // debris
        push();
        rotateZ(radians(-35 + rotation(t)*2));
        shape(bigdebris,0,0);
        rotateZ(radians(180));
        shape(smalldebris,0,0);
        pop();
        
        // outer ring
        shape(outer,0,0);
        
        // outer debris
        push();
        rotateZ(radians(rotation(t)));
        shape(outerdebris,0,0);
        rotateZ(radians(180));
        shape(outerdebris,0,0);
        pop();
        pop();
        
        //render_ascii(255);
        
        if (SAVE) saveFrame("frames\\frame###" + SAVEAS);
    }
    
}

float spin(float t, int n) {
    if (0 <= t && t < 0.5) return map(sin(PI * t), -1, 1, 0, 360*n);
    return 0;
}

float rotation(float t) {
    return map(t, 0, 1, 0, 180);
}

color colorFunc(float t) {
    t = map(t, 0, 0.1, 0, 1);
    return lerpColor(blue, purple, -(cos(PI * t) -1.0) / 2.0);
}

void refresh(color c) {
    outerdebris.setFill(c);
    outerdebris.setStroke(c);
    outer.setFill(c);
    outer.setStroke(c);
    bigdebris.setFill(c);
    bigdebris.setStroke(c);
    smalldebris.setFill(c);
    smalldebris.setStroke(c);
    half.setFill(c);
    half.setStroke(c);
    inner.setFill(c);
    inner.setStroke(c);
    
}

PShape give(float r1, float r2, int angle) {
    PShape self = createShape();
    self.beginShape();
    float x = 0, y = 0;
    for (int i = 0; i <= angle; ++i) {
        x = r1*sin(TWO_PI*map(i, 0, 360, 0, 1));
        y = -r1*cos(TWO_PI*map(i, 0, 360, 0, 1));
        self.vertex(x,y);
    }
    for (int i = angle; i >= 0; --i) {
        x = r2*sin(TWO_PI*map(i, 0, 360, 0, 1));
        y = -r2*cos(TWO_PI*map(i, 0, 360, 0, 1));
        self.vertex(x,y);
    }
    self.endShape(CLOSE);
    return self;
}
