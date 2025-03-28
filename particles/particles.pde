// Autor: Renée Richter
// Datum: 09.07.2024
// Zweck: Particles Noise Connected Stuff

int numFrames = 300;
OpenSimplexNoise noise;
int N = 100;
Particle[] parts;
boolean SAVE = true;
String SAVEAS = ".png";
int bigR = 250;
int off = 200;
//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 5;
float shutterAngle = 1.2;
boolean recording = true;

// motion blur template by beesandbombs

int[][] result; // pixel colors buffer for motion blur
float t; // time global variable in [0,1[
float c; // other global variable for testing things, controlled by mouse

void draw()
{
    if (!recording) // test mode...
    { 
        t = mouseX*1.0/width;
        c = mouseY*1.0/height;
        if (mousePressed)
            println(c);
        draw_();
    }
    else // render mode...
    { 
        for (int i=0; i<width*height; i++)
            for (int a=0; a<3; a++)
                result[i][a] = 0;

        c = 0;
        for (int sa=0; sa<samplesPerFrame; sa++) {
            t = map(frameCount-1 + sa*shutterAngle/samplesPerFrame, 0, numFrames, 0, 1);
            t %= 1;
            draw_();
            loadPixels();
            for (int i=0; i<pixels.length; i++) {
                result[i][0] += red(pixels[i]);
                result[i][1] += green(pixels[i]);
                result[i][2] += blue(pixels[i]);
            }
        }

        loadPixels();
        for (int i=0; i<pixels.length; i++)
            pixels[i] = 0xff << 24 | 
                int(result[i][0]*1.0/samplesPerFrame) << 16 | 
                int(result[i][1]*1.0/samplesPerFrame) << 8 | 
                int(result[i][2]*1.0/samplesPerFrame);
        updatePixels();
        
        if (frameCount<=numFrames) {
            saveFrame("frames\\frame###" + SAVEAS);
            println(frameCount,"/",numFrames);
        }
        
        if (frameCount==numFrames)
            exit();
    }
}

void setup() {
    size(800,800);
    noise = new OpenSimplexNoise(1333);
    parts = new Particle[N];
    for (int i = 0; i < N; ++i) {
        parts[i] = new Particle(i);
    }
    
    result = new int[width*height][3];
}

void draw_() {
    
    background(0);
    //float t = 1.0 * (frameCount-1) / numFrames % 1;
    
    for (Particle p : parts) {
        p.update(t);
    }
    
    for (Particle p : parts) {
        p.drawMe();
    }
    
    //if (SAVE && frameCount <= numFrames) saveFrame("frames\\frame###" + SAVEAS);
    
}

class Particle {
    
    int index;
    float x, y;
    int maxDistance = 120;
    boolean[] connects = new boolean[N];
    
    Particle(int tindex) {
        index = tindex;
    }
    
    void update(float t) {
        
        float minX = width/2 - bigR;
        float maxX = width/2 + bigR;
        float minY = height/2 - bigR;
        float maxY = height/2 + bigR;
        x = map(noiseFunc(index, t,  1), -0.7, 0.7, 0-off, width+off);
        y = map(noiseFunc(index, t, -1), -0.7, 0.7, 0-off, height+off);
        
        // x = constrain(x, minX, maxX);
        // y = constrain(y, minY, maxY);
        
        /* if (x < width/2) {
            float a = dist(width/2, min, x, y);
            float b = bigR;
            float c = dist(width/2, height/2, x, y);
            float alpha = acos((b*b + c*c - a*a) / (2*b*c)); //<>//
            float thisT = alpha/TWO_PI;
            
        }
        */ 
        
    }
    
    void drawMe() {
        
        updateConnectsArray();
        
        push();
        color c1 = color(255, 75, 0);
        color c2 = color(0, 75,  255);
        
        for (int i = index+1; i < N; ++i) {
            if (connects[i]) {
                
                float distance = dist(x, y, parts[i].x, parts[i].y);
                // color c = lerpColor(c1, c2, map(distance, 0, maxDistance, 0, 1));
                color c = lerpColor(c1, c2, map(min(x,parts[i].x), 0, width, 0, 1));
                float thicc = map(distance, 0, maxDistance, 5, 0);
                
                stroke(c);
                strokeWeight(thicc);
                line(x, y, parts[i].x, parts[i].y);
            }
        }
        
        strokeWeight(5);
        stroke(200);
        point(x,y);
        pop();
    }
    
    void updateConnectsArray() {
        
        for (int i = 0; i < N; ++i) {
            
            if (i == index) { connects[i] = false; continue; }
            
            float distance = dist(x, y, parts[i].x, parts[i].y);
            if (distance <= maxDistance) connects[i] = true;
            else connects[i] = false;
        }
    }
    
}

float noiseFunc(int i, float t, int isItX) {
    float rad = 0.1;
    return (float) noise.eval(isItX*1*i + rad * sin(TWO_PI * t), rad * -cos(TWO_PI * t));
}
