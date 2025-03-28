// Autor: René Richter
// Datum: 02.05.2024
// Zweck: Stuff. Der sich bewegt. Und rotiert. Oder so.

int numFrames = 120;
boolean LOOP = true;
boolean SAVE = true;
String SAVEAS = ".png";
int[] sizes = new int[] {20,30,40,50,60,70};
int abstand = 100;
float[] nextCoords = new float[] { 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1,
                                  -1, 0,-1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
                                  -1, 0,-1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
                                  -1, 0,-1, 0,-1, 0,-1, 0,-1, 0, 0,-1,
                                   1, 0, 1, 0, 0,-1,-1, 0,-1, 0, 0,-1,
                                   1, 0, 1, 0, 0,-1,-1, 0,-1, 0, 0,-1 };

void setup() {
    size(800,800,P3D);
    rectMode(CENTER);
}

void draw() {
    
    if (LOOP || frameCount <= numFrames) {
        
        background(0);
        stroke(255);
        noFill();
        
        float t = 1.0*(frameCount-1)/numFrames % 1;
        
        translate(350,150);
        
        for (int i = 0; i < nextCoords.length/(2*sizes.length); ++i) {
            for (int j = 0; j < sizes.length; ++j) {
                pushMatrix();
                
                int offset = floor(sizes.length * t);
                int index = 2*i+j+offset;
                translate(period(t) * abstand * nextCoords[2*sizes.length*i+j], period(t) * abstand * nextCoords[2*sizes.length*i+j+1]);
                rotateX(t * PI/2);
                rotateY(t * PI/2);
                rotateZ(t * PI/2);
                box(40);
                
                popMatrix();
                translate(abstand * nextCoords[2*sizes.length*i+j], abstand * nextCoords[2*sizes.length*i+j+1]);
            }
            
        }
        
        if (SAVE && frameCount <= numFrames) saveFrame("frames\\frame###" + SAVEAS);
    }
    
}

float period(float t) {
    return -0.5 * cos(TWO_PI*t) + 0.5;
}

float period2(float t) {
    return 0;
}
