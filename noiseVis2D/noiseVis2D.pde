OpenSimplexNoise noise;
int N = 100;
int numFrames = 120;
float zoom = 0.01;
boolean SAVE = true;
String SAVEAS = ".png";
boolean LOOP = false;
float radius = 0.5;

void setup() {
    size(800,800);
    noise = new OpenSimplexNoise(22441);
    
}

void draw() {
    
    if (LOOP || frameCount <= numFrames) {
    
        float t = 1.0 * (frameCount-1)/numFrames % 1;
        background(0);
        
        for (int i = 0; i < N; ++i) {
            for (int j = 0; j < N; ++j) {
                float x = map(i, 0, N-1, 0, width);
                float y = map(j, 0, N-1, 0, height);
                float z = radius*cos(TWO_PI*t);
                float w = radius*sin(TWO_PI*t);
                float cInt = int(map((float) noise.eval(zoom*x,zoom*y,z,w), -1, 1, 0, 255));
                color c = color(cInt, 0, 0);
                fill(c);
                stroke(c);
                float d = 1.0*width/N;
                square(x,y,d);
            }
        }
        
        if (SAVE) saveFrame("frames\\frame###" + SAVEAS);
    }
}
