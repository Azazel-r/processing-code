int numFrames = 240;
String ascii = "Ñ@#W$9876543210?!abc;:+=-,._ ";
PFont myFont;
int rad = 122;
int X = 80;
int Y = 80;
int off = 10;
float zooom = 0.0025;
OpenSimplexNoise noise;

boolean SAVE = true;
String SAVEAS = ".png";
boolean LOOP = false;

void setup() {
    size(800,800,P3D);
    myFont = createFont("Courier", 12);
    textAlign(CENTER, CENTER);
    noise = new OpenSimplexNoise(345);
}

void draw() {
    if (LOOP || frameCount <= numFrames) {
        background(0);
        float t = 1.0 * (frameCount-1) / numFrames % 1;
        fill(255);
        textFont(myFont);
        
        for(int i = 0; i < X; i++) {
            for (int j = 0; j < Y; j++) {
                
                pushMatrix();
                float x = map(i, 0, X-1, off, width-off);
                float y = map(j, 0, Y-1, off, height-off);
                float noiseShit = periodNoise(t, x, y, zooom);
                noiseShit = truncate(noiseShit, 0);
                char myChar = ascii.charAt(constrain(floor(map(noiseShit, -1, 0.5, ascii.length()-1, 0)),0,ascii.length()-1));
                float z = map(noiseShit, -1, 1, 0, 300);
                translate(0,0,z);
                text(myChar, x, y);
                popMatrix();
                
            }
        }
        
        if (SAVE) saveFrame("frames\\frame###" + SAVEAS);
    }
}

float truncate(float noiseVal, float cut) {
    if (noiseVal < cut) return -1;
    else return map(noiseVal, cut, 1, -1, 1);
}

float period(float p) {
    return -cos(PI * p)/2 + 0.5;
}

float periodNoise(float p, float x, float y, float zoom) {
    float r = 0.5;
    float third = r * cos(TWO_PI*p);
    float fourth = r * sin(TWO_PI*p);
    return 1.0 * (float) noise.eval(zoom*x, zoom*y, third, fourth);
}
