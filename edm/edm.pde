OpenSimplexNoise noise;
int N = 10;
float d;
int numFrames = 240;
float[] noiseVals;
float offset = 10;
float noiseOffset = 0.2;
color c1 = color(214,2,112);
color c2 = color(0,56,168);

boolean SAVE = true;
String SAVEAS = ".png";
boolean LOOP = false;

void setup() {
    size(800,800);
    d = 0.85 * width/N;
    offset += d/2;
    rectMode(CENTER);
    noise = new OpenSimplexNoise(42);
    noiseVals = new float[N];
}

void draw() {
    
    if (LOOP || frameCount <= numFrames) {
        float t = 1.0 * (frameCount-1) / numFrames % 1;
        background(0);
        noStroke();
        fill(255);
        
        for (int j = 0; j < N; j++) {
            noiseVals[j] = period(t, j*0.5);
        }
        
        for (int i = 0; i < N; i++) {
            int n = constrain(floor(map(noiseVals[i], -1+noiseOffset, 1-noiseOffset, 0, N)), 0, N) + 1;
            float x = map(i, 0, N-1, offset, width-offset);
            for (int j = 0; j < n; j++) {
                float y = map(j, 0, N-1, height-offset, offset);
                float colorVal = map(j, 0, N, 0, 1);
                color col = lerpColor(c1, c2, colorVal);
                fill(col);
                rect(x,y,d,d);
            }
        }
        
        if (SAVE && frameCount <= numFrames) saveFrame("frames\\frame###" + SAVEAS);
    }
    
}

float period(float p, float seed) {
    float radius = 1.5;
    return 1.0 * (float) noise.eval(radius * cos(TWO_PI*p) + seed, radius * sin(TWO_PI * p));
}
