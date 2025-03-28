Ring ring;
int numFrames = 240;
boolean SAVE = true;
String SAVEAS = ".png";
boolean LOOP = false;
color COL1 = color(30,120,30);
color COL2 = color(200,200,30);

void setup() {
    size(800,800,P3D);
    sphereDetail(15);
    ring = new Ring(12, width/2, height/2, 0, 350, 40, COL1, COL2);
    setup_ascii();
}

void draw() {
    
    if (LOOP || frameCount <= numFrames) {
    
        float t = 1.0 * (frameCount-1) / numFrames % 1;
        
        background(0);
        lights();
        ring.drawMe(degrees(TWO_PI*t),degrees(TWO_PI*t),degrees(TWO_PI*t));
        //translate(width/2, height/2);
        //sphere(300);
        
        // render_ascii(0);
        
        if (SAVE) saveFrame("frames\\frame###" + SAVEAS);
        
    }
}

class Ring {
    
    int n;
    float x, y, z, r, smallr;
    color c1, c2;
    
    Ring(int tn, float tx, float ty, float tz, float tr, float tsmallr, color tc1, color tc2) {
        n = tn;
        x = tx;
        y = ty;
        z = tz;
        r = tr;
        smallr = tsmallr;
        c1 = tc1;
        c2 = tc2;
    }
    
    void drawMe(float X, float Y, float Z) {
        pushMatrix();
        translate(x,y,z);
        rotateX(radians(X));
        rotateY(radians(Y));
        rotateZ(radians(Z));
        noStroke();
        //strokeWeight(.5);
        
        for (int i = 0; i < n; ++i) {
            float myN = 1.0 * i / n;
            float myY = r*cos(TWO_PI*myN);
            float myX = r*sin(TWO_PI*myN);
            float myColValue = 1.0 * i / (n/2);
            if (myColValue > 1) myColValue = 1 + (1 - myColValue);
            color myCol = lerpColor(c1, c2, myColValue);
            pushMatrix();
            translate(myX,myY);
            fill(myCol);
            sphere(smallr);
            popMatrix();
        }
        
        popMatrix();
    }
    
}
