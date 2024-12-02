//
//
//

int numFrames = 200;
boolean SAVE = false;
String SAVEAS = ".gif";

void setup() {
    size(800,800);
}

void draw() {
    
    background(0);
    float t = 1.0 * (frameCount-1) / numFrames % 1;
    
    translate(width/2, height/2);
    //rotate(TWO_PI * t);
    
    int anzahl = 3;
    
    for (int i = 0; i < anzahl; ++i) {
        drawTrail(t + (1.0 * i / anzahl), denseFunction(t), thickFunction(t), 1.0/(anzahl+1));
    }
    
    if (SAVE && frameCount <= numFrames) saveFrame("frames\\frame###" + SAVEAS);
    
}

void drawTrail(float t, int n, int r2, float len) {
    
    push();
    float r = 325;
    color c1 = color(230,0,0);
    color c2 = color(0,0,230);
    
    for (int i = 0; i < n; ++i) {
        
        float newT = t - map(i, 0, n, 0, len);
        if (newT < 0) newT++;
        else if (newT > 1) newT--;
        color c = colorFunction(c1, c2, newT); // lerpColor(c1, c2, map(i, 0, n, 0, 1));
        float y = -cos(TWO_PI * newT) * r;
        float x = sin(2 * TWO_PI * newT) * r/2;
        strokeWeight(r2 * (1 - sin(0.5 * PI * map(i, 0, n, 0, 1))));
        stroke(c);
        point(y,x);
        
    }
    
    pop();
}

color colorFunction(color c1, color c2, float t) {
    if (t < 0.5) return lerpColor(c1, c2, map(t, 0, 0.5, 0, 1));
    else return lerpColor(c2, c1, map(t, 0.5, 1, 0, 1));
}

int denseFunction(float t) {
    int start = 15;
    int end = 300;
    float erg = t < 0.5 ? quadShit(t*2) : quadShit(2 - t*2);
    // println(erg);
    return floor(map(erg, 0, 1, start, end));
}

float quadShit(float t) {
    return t < 0.5 ? 16 * t * t * t * t * t : 1 - pow(-2 * t + 2, 5) / 2;
}

int thickFunction(float t) {
    int start = 3;
    int end = 40;
    return floor(map(sin(TWO_PI * t), -1, 1, start, end));
}
