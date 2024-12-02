OpenSimplexNoise noise;
int numFrames = 200;
myFontSize fontObj;
Line[] l;
PFont fallback;
float fact = 1;
float betterFactor = 0.25;
boolean SAVE = false;
boolean LOOP = true;
String saveAs = ".png";

void setup() {
    size(800,800, P3D);
    textAlign(CENTER, CENTER);
    fontObj = new myFontSize("PetMe64.ttf", 2, 40);
    fallback = createFont("Courier", 12);
    noise = new OpenSimplexNoise(55);
    l = new Line[50]; //new Line(222, -200, width+200, 250, 5);
    for (int i = 0; i < l.length; ++i) {
        int help = 0;
        float[] werte = new float[] {(float) noise.eval(pow(10, help++) + fact*i, 0),
                                     (float) noise.eval(pow(10, help++) + fact*i, 0),
                                     (float) noise.eval(pow(10, help++) + fact*i, 0),
                                     (float) noise.eval(pow(10, help++) + fact*i, 0),
                                     (float) noise.eval(pow(10, help++) + fact*i, 0),
                                     (float) noise.eval(pow(10, help++) + fact*i, 0),
                                     (float) noise.eval(pow(10, help++) + fact*i, 0)};
                                     
        l[i] = new Line(map(better(werte[0]), -1, 1, 30, height-30),
                        map(better(werte[1]), -1, 1, -200, 200),
                        map(better(werte[2]), -1, 1, -200, 0),
                        map(better(werte[3]), -1, 1, width, width+200),
                        map(better(werte[4]), -1, 1, 50, 300),
                        map(better(werte[5]), -1, 1, 10, 40),
                        map(better(werte[6]), -1, 1, 0, 1.5));
    }
}

void draw() {
    
    if (LOOP || frameCount <= numFrames) {
        background(0);
        float t = 1.0 * (frameCount-1) / numFrames % 1;
        for (int i = 0; i < l.length; ++i) {
            l[i].drawMe(t);
        }
        
        if (SAVE) saveFrame("frame###" + saveAs);
    }
}

class Line {
    
    float y, z, startx, endx, len, size, off;
    
    Line(float ty, float tz, float tstartx, float tendx, float tlen, float tsize, float toff) {
        y = ty;
        z = tz;
        startx = tstartx;
        endx = tendx;
        len = tlen;
        size = tsize;
        off = toff;
    }
    
    void drawMe(float p) {
        p = (p+off) % 1;
        pushMatrix();
        translate(0,0,z);
        float x = map(p, 0, 1, startx, endx);
        int n = floor(len/size);
        float abstand = size + len/size - n;
        for (int i = 0; i < n; ++i) {
            float myX = x + abstand/2 + i*abstand;
            if (myX > endx) myX = startx + myModulo(myX, endx);
            
            PFont thisFont;
            try { thisFont = fontObj.getFont(floor(map(i, 0, n, 2, size))); }
            catch (Exception e) { thisFont = fallback; }
            textFont(thisFont);
            fill(200, 200);
            text("E", myX, y);
        }
        popMatrix();
    }
}

float better(float f) {
    return constrain(map(f,-1,1,-1-betterFactor,1+betterFactor),-1,1);
}

float myModulo(float a, float b) {
    if (a >= 0 && b >= 0) return a % b;
    else if (a < 0 && b >= 0) return b - abs(a) % b;
    else if (a >= 0 && b < 0) return -abs(b) + a % abs(b);
    else return -1 * (abs(a) % abs(b));
}

class myFontSize {
    
    PFont[] fontArray;
    int start, end;
    
    myFontSize(String fontName, int tstart, int tend) {
        
        start = tstart;
        end = tend;
        
        fontArray = new PFont[end-start+1];
        for (int i = 0; i < fontArray.length; ++i) {
            fontArray[i] = createFont(fontName, start+i);
        }
        
    }
    
    PFont getFont(int n) throws Exception {
        if (start <= n  && n <= end) return fontArray[n];
        throw new Exception();
    }
    
}
