int numFrames = 240;
boolean SAVE = true;
String SAVEAS = ".png";
boolean LOOP = false;
float rot = 0;

void setup() {
    size(800,800, P3D);
}

void draw() {
    if (LOOP || frameCount <= numFrames) {
        
        float t = 1.0 * (frameCount-1)/numFrames % 1;
        
        background(255);
        stroke(0);
        strokeWeight(3);
        fill(128);
        pushMatrix();
        translate(width/2, height/2, 0);
        rot += 720.0/numFrames * period(t);
        rotateY(radians(rot));
        translate(200,0,0);
        rotateX(radians(rot*2));
        rectMode(CENTER);
        rect(0,0,150,150);
        popMatrix();
        
        if (SAVE) saveFrame("frames\\frame###" + SAVEAS);
    }
}

float period(float p) {
    return map(-cos(TWO_PI*p),-1,1,0,1);
}
