PFont f;
myCircle c;
int kreise = 16;

void setup() {
    size(800,800);
    f = createFont("PetMe64.ttf", 40);
    textFont(f);
    textAlign(CENTER, CENTER);
    fill(0);
    c = new myCircle(width/2, height/2, 250, kreise, 15);
}

void draw() {
    if (frameCount <= kreise) {
        background(230);
        c.drawMe();
        text(dez2bin(c.active, (int) log2(kreise)), width/2, height/2);
        c.update();
        saveFrame("frame###.gif");
    }
}

class myCircle {
    
    float[] X, Y;
    float centerX, centerY;
    float radius;
    float radiusSmall;
    int N;
    int active;
    boolean[] animate;
    
    myCircle(float tx, float ty, float tr, int tn, float tsize) {
        centerX = tx;
        centerY = ty;
        radius = tr;
        N = tn;
        radiusSmall = tsize*2;
        active = 0;
        animate = new boolean[N];
        X = new float[N];
        Y = new float[N];
        for (int i = 0; i < N; i++) {
            X[i] = radius*sin(TWO_PI*i/N);
            Y[i] = radius*cos(TWO_PI*i/N);
        }
    }
    
    void drawMe() {
        stroke(0);
        strokeWeight(radiusSmall);
        for (int i = 0; i < N; i++) point(centerX+X[i], centerY-Y[i]);
        stroke(255);
        strokeWeight(3*radiusSmall/4);
        point(centerX+X[active], centerY-Y[active]);
    }
    
    void update() {
        active++;
        active %= N;
    }
    
}

float log2(float x) {
    return log(x)/log(2);
}

String dez2bin(int n, int padding) {
    String erg = "";
    while (n != 0) {
        erg = (n % 2) + erg;
        n /= 2;
    }
    if (padding != -1 && erg.length() < padding) {
        int diff = padding - erg.length();
        for (int i = 0; i < diff; i++) erg = '0' + erg;
    }
    return erg;
}
