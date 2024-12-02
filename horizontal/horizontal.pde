int numFrames = 60;
int N = 80;
int MAXSIZE = 10;
int MINSIZE = 0;
boolean SAVE = false;
boolean LOOP = true;

void setup() {
    size(1000,1000);
}

void draw() {
    
    if (LOOP || frameCount <= numFrames) {
        background(0);
        stroke(255);
        float t = 1.0*(frameCount-1)/numFrames % 1;
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                
                float x = map(i, 0, N-1, MAXSIZE/2, width-MAXSIZE/2);
                float y = map(j, 0, N-1, MAXSIZE/2, height-MAXSIZE/2);
                float size = period(t + offset(x,y) + offset2(x)[0] - offset2(x)[1] - offset2(y)[0] + offset2(y)[1]);
                // für ver2:
                // float size = period(t + offset(x,y) + offset2(x)[0] - offset2(x)[1]);
                
                strokeWeight(size);
                point(x,y);
                
            }
        }
        if (SAVE) saveFrame("frame###.gif");
    }
}

float period(float p) {
    return map(sin(TWO_PI*p),-1,1,MINSIZE,MAXSIZE);
}

float offset(float x, float y) {
    float option1 = dist(x, y, width-MAXSIZE/2, MAXSIZE/2);
    float option2 = dist(x, y, MAXSIZE/2, height-MAXSIZE/2);
    float option3 = dist(x, y, width-MAXSIZE/2, height-MAXSIZE/2);
    float option4 = dist(x, y, MAXSIZE/2, MAXSIZE/2);
    return 0.01 * min(new float[] {option1, option2, option3, option4});
}

float[] offset2(float x) {
    float option1 = 0.005 * (900-x);
    float option2 = 0.005 * (x-900);
    return new float[] {option1, option2};
}
