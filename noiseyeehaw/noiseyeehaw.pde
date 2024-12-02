OpenSimplexNoise noise;
int numFrames = 200;
int N = 60;
float radii = 1.1;
boolean SAVE = true;
String SAVE_AS = ".png";
boolean LOOP = false;
color COL1 = 255;
color COL2 = 0;

void setup() {
    noise = new OpenSimplexNoise(22334);
    size(600,600);
}

void draw() {
    
    if (LOOP || frameCount <= numFrames) {
    
        float t = 1.0 * (frameCount-1) / numFrames % 1;
        background(COL2);
        
        for (int i = 0; i < N; i++) {
            float noiseVal = period(t, i*12.34);
            color thisColor = period3(t, i*12.34);
            float size = period2(t, i*23.45);
            pushMatrix();
            translate(width/2, height/2);
            rotate(radians(i * 360/N));
            translate(0, noiseVal);
            stroke(thisColor);
            strokeWeight(size);
            point(0,0);
            popMatrix();
        }
        
        if (SAVE) saveFrame("frames\\frame###" + SAVE_AS);
        
    }
}

float period(float p, float seed) {
    float noiseVal = 1.0 * (float) noise.eval(seed + radii*cos(TWO_PI*p), radii*sin(TWO_PI*p));
    return map(noiseVal, -1, 1, 0, dist(0,0,width/2 - 50 ,height/2 - 50));
}

float period2(float p, float seed) {
    float noiseVal = 1.0 * (float) noise.eval(seed + radii*cos(TWO_PI*p), radii*sin(TWO_PI*p));
    return map(noiseVal, -1, 1, 0, 15);
}
color period3(float p, float seed) {
    float noiseVal = 1.0 * (float) noise.eval(seed + radii*cos(TWO_PI*p), radii*sin(TWO_PI*p));
    color c1 = color(214,2,112);
    color c2 = color(0,56,168);
    return lerpColor(c1,c2,map(noiseVal, -1, 1, 0, 1));
}
