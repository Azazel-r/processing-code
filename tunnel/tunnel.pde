// motion blur template by beesandbombs modified by azazel_r

// Autor: Renée Richter
// Datum: 06.09.2024
// Zweck: Tunnel Animation juhu

int[][] result; // pixel colors buffer for motion blur
float t; // time global variable in [0,1[
float c; // other global variable for testing things, controlled by mouse

int samples = 10;
int numFrames = 120;       
float shutter = 1.3;
boolean SAVE = true;
String SAVEAS = ".png";

void setup() {
    size(800,800,P3D);
    result = new int[width*height][3];
    rectMode(CENTER);
}

void draw_() {
    
    push();
    
    background(0);
    int Z = -750;
    translate(width/2, height/2, Z);
    
    int rad = 100;
    int N = 100;
    int weight = 3;
    color[] cols = new color[] {color(255,0,0,85), color(0,255,0,85), color(0,0,255,85)};
    float[] facts = new float[] {0.25, 0.5, 1};
    
    noFill();
    strokeWeight(weight);
    
    for (int j = 0; j < 3; ++j) {
        
        push();
        
        float rot = TWO_PI * t * facts[j];
        rotateZ(rot);
        stroke(cols[j]);
        
        for (int i = 0; i < N; ++i) {
            
            square(0,0,rad);
            translate(0,0,20);
            rotateZ(TWO_PI / N);
            
        }
        
        pop();
    }
    
    pop();
    
}

//////////////////////////////////////////////////////////////////////////////

void draw()
{
    if (!SAVE) // test mode...
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
        for (int sa=0; sa<samples; sa++) {
            t = map(frameCount-1 + sa*shutter/samples, 0, numFrames, 0, 1);
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
                int(result[i][0]*1.0/samples) << 16 | 
                int(result[i][1]*1.0/samples) << 8 | 
                int(result[i][2]*1.0/samples);
        updatePixels();
        
        if (frameCount<=numFrames) {
            saveFrame("frames\\frame###" + SAVEAS);
            println(frameCount,"/",numFrames," frames");
        }
        
        if (frameCount==numFrames)
            exit();
    }
}
