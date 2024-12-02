// Autor: René Richter
// Datum: 27.11.2024
// Zweck: Testen versch. Space filling curves (alles von mir selbst implementiert)

// Variables to change:
int N = 0;
int curve = 3; // 1 = hilbert // 2 = fractal // 3 = my own
int mode = 1; // 1 = draw instant // 2 = draw one line each frame // 3 = zoom (TODO)

int margin = 150;
int numFrames = 300;
boolean SAVE = false;
String SAVEAS = ".gif";

// dont change pls
int ROT = 1;
float LEN;
float FACT = 2.64757;
int counter = 1;
int internalcounter = 0;
boolean slow = mode == 2;
int MAX;


void setup() {
    
    size(800,800);
    if (curve < 3) LEN = (width-2*margin) * 1.0/pow(curve == 1 ? 2 : FACT, N+1);
    else LEN = getLen(N);
    print(LEN);
    if      (curve == 1) MAX = (int) pow(4,N+1)-1;
    else if (curve == 2) MAX = (int) pow(7,N+1);
    //frameRate(1);
    
}

void draw() {
    
    background(0);
    stroke(200,200,20);
    float t = 1.0 * (frameCount-1) / numFrames % 1;
    if (mode == 1) {
        
        if (curve == 1) {
            
            translate(margin + LEN/2, height - margin - LEN/2);
            if (N % 2 == 0) rotate(-PI/2);
            hilbertCurve(N, LEN, ROT);
            
        } else if (curve == 2) {
            
            translate(margin, 0.86 * height - margin);
            rotate((N +1)* 0.33);
            fractalCurve(N, LEN, true);
            
        } else if (curve == 3) {
            
            translate(margin, -margin + height);
            rotate(-PI/2);
            if (N % 2 == 1) rotate(PI/4);
            myCurve(N, LEN, ROT);
            
        }
        
    } else if (mode == 2) {
            
        if (SAVE && counter > MAX) exit();
        internalcounter = 0;
        counter++;
        
        if (curve == 1) { 
            
            translate(margin + LEN/2, height - margin - LEN/2);
            if (N % 2 == 0) rotate(-PI/2);
            hilbertCurve(N, LEN, ROT);
            
        } else if (curve == 2) {
            
            translate(margin, 0.86 * height - margin);
            rotate((N +1)* 0.33);
            fractalCurve(N, LEN, true);
            
        }

    } else if (mode == 3) {
        
        if (curve == 3) {

            int tempN = t < .5 ? N : N+1; // t < .25 ? N : t < .5 ? N+1 : t < .75 ? N+2 : N+3;
            float tempLen = map(period(t), 0, 1, 1200, 8*1200); // sqrt(8*(pow(600,2))); // map(t, 0, 1, 1000, 1000);
            int tempRot = ROT; // t < .5 ? -ROT : ROT;
            translate(width/2, height/2);
            rotate(TWO_PI*period(t));
            //if (t >= .5) rotate(PI/4 * (t-.5)*2);
            rotate(-PI/2);
            if (tempN % 2 == 1) rotate(PI/4);
            pushMatrix();
            myCurve2(tempN, tempLen, tempRot);
            popMatrix();
            rotate(PI);
            myCurve2(tempN, tempLen, tempRot);
        }
        
    }

    if (SAVE && frameCount <= numFrames) saveFrame("frames\\frame####" + SAVEAS);
}

void keyPressed() {
    if (mode != 1) return;
    if      (key == '+') ++N;
    else if (key == '-') --N;
    if (N < 0) N = 0;
    if (curve < 3) LEN = (width-2*margin) * 1.0/pow(curve == 1 ? 2 : FACT, N+1);
    else LEN = getLen(N);
}

void l(float len) {
    line(0,0,len,0);
    translate(len,0);
}

float getLen(int n) {
    float erg = 0.5 * (height - 2*margin);
    for (int i = 0; i < n; ++i) {
        erg = 0.5 * sqrt(pow(erg,2) / 2);
    }
    return erg;
}

float period(float p) {
    return p < 0.5 ? 2*p*p : 1 - pow(-2 * p + 2, 2) / 2;
}
