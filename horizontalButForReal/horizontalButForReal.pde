int numFrames = 60;
boolean SAVE = true;
String SAVEAS = ".png";
boolean LOOP = false;
int N = 127;
float MAXSIZE = 10;
float[][] punkte;
int strings = 1;

void setup() {
    
    size(800,800);
    punkte = new float[strings][];
    for (int i = 0; i < strings; i++) {
        punkte[i] = randomRandpunkt();
    }
    
}

void draw() {
    if (LOOP || frameCount <= numFrames) {
        background(0);
        stroke(255);
        myCross(width/2, height/2, 10, color(255,0,0));
        float t = 1.0 * (frameCount-1)/numFrames % 1;
        for (int j = 0; j < punkte.length; j++) {
            int stelle = (int) punkte[j][2];
            int[] range = punkte[j][stelle] < width/2 ? new int[] {0, N-1} : new int[] {N-1, 0};
            int[] range2 = punkte[j][not(stelle)] < width/2 ? new int[] {0, N-1} : new int[] {N-1, 0};
            for (int i = 0; i < N; i++) {
                float coord = map(i, range[0], range[1], MAXSIZE/2, width-MAXSIZE/2);
                float coord2 = map(i, range2[0], range2[1], punkte[j][not(stelle)], getOppositeSide(punkte[j][not(stelle)]));
                if (punkte[j][2] == 0) {
                    println("i: " + i);
                    float size = period(t - offset(coord, coord2, punkte[j][stelle], punkte[j][not(stelle)]) - 1.0*j/punkte.length, punkte.length);
                    strokeWeight(size < 0 ? 0 : size);
                    point(coord, coord2);
                    if (i == 0) myCross(coord, coord2, 10, color(0,255,0)); else if (i == N-1) myCross(coord, coord2, 10, color(0,0,255));
                } else {
                    println("i: " + i);
                    float size = period(t - offset(coord2, coord, punkte[j][stelle], punkte[j][not(stelle)]) - 1.0*j/punkte.length, punkte.length);
                    strokeWeight(size < 0 ? 0 : size);
                    point(coord2, coord);
                    if (i == 0) myCross(coord2, coord, 10, color(0,255,0)); else if (i == N-1) myCross(coord2, coord, 10, color(0,0,255));
                }
            }
            /*
            float coord = map(i, 0, N-1, MAXSIZE/2, width-MAXSIZE/2);
            float size = period(t - offset(coord));
            float size2 = period(t - offset(coord) - 0.5);
            strokeWeight(size < 0 ? 0 : size);
            point(coord,coord);
            strokeWeight(size2 < 0 ? 0 : size2);
            point(width-coord, coord);
            */
        }
        println("-------------------------");
        if (SAVE) saveFrame("frames\\frame###" + SAVEAS);
    }
    
}

float period(float p, int q) {
    return map(sin(TWO_PI * p), -1, 1, -1.0 * MAXSIZE*q*q, MAXSIZE);
}

float offset(float x, float y, float x2, float y2) {
    println(dist(x,y,x2,y2));
    return 1.0/width * dist(x,y,x2,y2);
}

int randint(int a, int b) {
    return int(random(a,b+1));
}

int not(int a) {
    return abs(a-1);
}

float getOppositeSide(float a) {
    return a + 2*(width/2 - a);
}

void myCross(float x, float y, float size, color c) {
    pushStyle();
    stroke(c);
    strokeWeight(3);
    line(x-size/2, y, x+size/2, y);
    line(x, y-size/2, x, y+size/2);
    popStyle();
}

float[] randomRandpunkt() {
    float[] erg = new float[3];
    int choice = randint(0,1);
    erg[choice] = map(randint(0,1), 0, 1, MAXSIZE/2, width-MAXSIZE/2);
    erg[abs(choice-1)] = map(randint(0,N-1), 0, N-1, MAXSIZE/2, width-MAXSIZE/2);
    erg[2] = choice;
    return erg;
}
