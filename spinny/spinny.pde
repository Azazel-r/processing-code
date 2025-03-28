int numFrames = 60;
int n = 50;
boolean SAVE = true;
String SAVEAS = ".png";
boolean LOOP = false;

void setup() {
    size(800,800);
}

void draw() {
    
    if (frameCount <= numFrames || LOOP) {
        background(0);
        float t = 1.0 * (frameCount-1)/numFrames % 1;
        
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                
                float x = map(i,0,n-1,0,width);
                float y = map(j,0,n-1,0,height);
                
                float size = period(t-offset(x,y)-offset2(x,y));
                color c = lerpColor(color(255,0,255), color(255,255,0), period2(t-offset(x,y)-offset2(x,y)));
                
                strokeWeight(size);
                stroke(c);
                
                point(x,y);
            }
        }
        
        if (SAVE) saveFrame("frames\\frame###" + SAVEAS);
    }
}

float period(float p) {
    return map(sin(TWO_PI*p), -1, 1, 0.05*n, 0.2*n);
}

float period2(float p) {
    return map(sin(TWO_PI*p), -1, 1, 0, 1);
}

float offset(float x, float y) {
    float angle = atan2(y-height/2, x-width/2);
    return map(angle,-PI,PI,0,n*0.1);
}

float offset2(float x, float y) {
    return 0.01 * dist(x,y,width/2,height/2);
}
