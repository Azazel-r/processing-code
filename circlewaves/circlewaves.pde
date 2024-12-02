OpenSimplexNoise noise;
int numFrames = 240;
PFont myFont, myFont2;
boolean SAVE = false;
boolean LOOP = true;
Pond p;
String end = "png";

void setup() {
    
    size(800,800,P3D);
    myFont = createFont("futura.ttf", 12);
    myFont2 = createFont("futura.ttf", 36);
    noise = new OpenSimplexNoise(34);
    p = new Pond(width*0.75, 50, 25, 40);
    p.preprocess();
    textAlign(CENTER, CENTER);
    lights();
    
}

void draw() {
    
    if (LOOP || frameCount <= numFrames) {
        
        background(0);
        float t = 1.0 * (frameCount-1) / numFrames % 1;
        rotateX(radians(40));
        translate(0,-150,-250);
        
        p.drawWater(t);
        p.drawEdge(3);
        p.drawTropfen(t);
        p.drawWiese();
        
        if (SAVE && frameCount <= numFrames) saveFrame("frame###." + end);
        
    }
    
}

float period(float x, float y, float t, float size) {
    float max = dist(0,0,size/2,size/2);
    float myVal = map(dist(x,y,size/2,size/2),0,max,0,1);
    return sineFunc((1 + myVal - t) % 1);
    
}

float noiseFunc(float t) {
    float r = 1;
    float val = map((float) noise.eval(r*sin(TWO_PI*t), r*cos(TWO_PI*t)),-1,1,0,1);
    return (val < 0) ? 0 : val;
}

float sineFunc(float t) {
    float erg;
    if (0 <= t && t < .4) erg = sin(TWO_PI*map(t,0,.4,0,1));
    else if (.4 <= t && t < .5) erg = map(sin(TWO_PI*map(t,.4,.5,0,1)),-1,1,-0.1,0.1);
    else if (.5 <= t && t < .8) erg = sin(TWO_PI*map(t,.5,.8,0,1));
    else erg = map(sin(TWO_PI*map(t,.8,1,0,1)),-1,1,-0.15,0.15);
    return erg;
}

class Pond {
    
    int N, intensity, N2;
    float size;
    float[][] coords;
    
    Pond(float tsize, int tN, int tint, int tN2) {
        size = tsize;
        N = tN;
        intensity = tint;
        N2 = tN2;
        coords = new float[int(pow(N*3, 2))][];
    }
    
    void preprocess() {
        float mySize = size*3;
        int myN = N*3;
        float zoom = 0.01;
        int index = 0;
        for (int i = 0; i < myN; ++i) {
            for (int j = 0; j < myN; ++j) {
                float x = map(i, 0, myN-1, -mySize/2, mySize/2);
                float y = map(j, 0, myN-1, -mySize/2, mySize/2);
                float noiseVal = (float) noise.eval(zoom*x, zoom*y);
                if (noiseVal > 0.3 && dist(x,y,0,0) > size/2 + 50) coords[index++] = new float[] {x,y,noiseVal};
            }
        }
    }
    
    void drawWater(float t) {
        textFont(myFont);
        fill(100,100,255,200);
        pushMatrix();
        translate((width-size)/2,(height-size)/2,30);
        for (int i = 0; i < N; ++i) {
            for (int j = 0; j < N; ++j) {
                float x = map(i,0,N-1,0,size);
                float y = map(j,0,N-1,0,size);
                float z = map(period(x,y,t,size),0,1,0,intensity);
                pushMatrix();
                translate(x,y,z);
                if (dist(x,y,size/2,size/2) <= size/2) text("9",0,0);
                popMatrix();
            }
        }
        popMatrix();
    }
    
    void drawEdge(int n) {
        textFont(myFont2);
        fill(100);
        pushMatrix();
        translate(width/2, height/2);
        for (int i = 0; i < n; ++i) {
            drawEdgeLayer();
            translate(0,0,40);
        }
        popMatrix();
    }
    
    void drawEdgeLayer() {
        float r = size/2 + 10;
        for (int i = 0; i < N2; ++i) {
            float val = 1.0 * i/N2;
            val %= 1;
            pushMatrix();
            translate(-r*sin(TWO_PI*val),-r*cos(TWO_PI*val));
            rotateX(radians(290));
            rotateY(radians(val*360));
            //if (!(0.25 <= val && val < 0.75)) rotateY(radians(val*360));
            //else rotateY(radians((1-val)*360));
            text("Y",0,0);
            popMatrix();
        }
        for (int i = 0; i < N2; ++i) {
            float val = 1.0 * i/N2 + 1.0/(N2*2);
            val %= 1;
            pushMatrix();
            translate(r*sin(TWO_PI*val),-r*cos(TWO_PI*val));
            rotateX(radians(110));
            rotateY(radians(val*360));
            //if ((0.25 <= val && val < 0.75)) rotateY(radians(val*360));
            //else rotateY(radians((1-val)*360));
            text("Y",0,0);
            popMatrix();
        }
    }
    
    void drawTropfen(float t) {
        float drop = 1500;
        float trans = 200;
        textFont(myFont2);
        float t1 = 0.25;
        float t2 = 0.65;
        float z1, z2;
        if (t < t1) z1 = map(t,0,t1,t1*drop,0);
        else z1 = map(t,t1,1,drop,t1*drop);
        if (t < t2) z2 = map(t,0,t2,t2*drop,0);
        else z2 = map(t,t2,1,drop,t2*drop);
        pushMatrix();
        translate(width/2, height/2, z1);
        rotateX(radians(310));
        if (z1 < 100) trans = map(z1,0,100,0,200);
        fill(100,100,255,trans);
        text("9",0,0);
        popMatrix();
        pushMatrix();
        translate(width/2, height/2, z2);
        rotateX(radians(310));
        trans = 200;
        if (z2 < 100) trans = map(z2,0,100,0,200);
        fill(100,100,255,trans);
        text("9",0,0);
        popMatrix();
    }
    
    void drawWiese() {
        float trans;
        pushMatrix();
        fill(255);
        textFont(myFont);
        translate(width/2, height/2);
        int index = 0;
        while (coords[index] != null) {
            trans = map((float) coords[index][2],0.3,1,50,255);
            fill(100,100,200,trans);
            text("y",coords[index][0], coords[index][1]);
            index++;
        }
        popMatrix();
    }
}
