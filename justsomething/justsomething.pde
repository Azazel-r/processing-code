// motion blur template by beesandbombs modified by azazel_r

// Autor: Renée Richter
// Datum: 08.01.2025
// Zweck: just another noise test wheee

int[][] result; // pixel colors buffer for motion blur
float t; // time global variable in [0,1[
float c; // other global variable for testing things, controlled by mouse

int samples = 10;
int numFrames = 200;       
float shutter = 1.2;
boolean SAVE = true;
String SAVEAS = ".gif";

// my stuff
OpenSimplexNoise noise;
int N = 40;
float margin = 0.0;
float l;
float radius = 1;
float zoom = 0.00125;

void setup(){
    size(800,800,P3D);
    result = new int[width*height][3];
    noise = new OpenSimplexNoise(2221);
    rectMode(CENTER);
    l = 1.0 * (width-2*margin)/N;
}

void draw_(){
    
    pushMatrix();
    translate(width/2, height/2);
    rotateX(TWO_PI * t);
    rotateY(TWO_PI * t);
    rotateZ(TWO_PI * t);
    background(0);
    stroke(0);
    lights();
    
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            pushMatrix();
            float x = map(i, 0, N, margin, width-margin) + 0.5 * l;
            float y = map(j, 0, N, margin, width-margin) + 0.5 * l;
            float z = radius*cos(TWO_PI*t);
            float w = radius*sin(TWO_PI*t);
            float noiseVal = period((float) noise.eval(zoom*x,zoom*y,z,w));
            translate(0,0,map(noiseVal, 0, 1, 0, -1000));
            fill(map(x+y, 2*margin, width+height - 2*margin, 255, 0));
            rotateX(TWO_PI * noiseVal);
            rotateY(TWO_PI * noiseVal);
            rotateZ(TWO_PI * noiseVal);
            square(x,y,l);
            popMatrix();
        }
    }
    
    popMatrix();
    
}

float period(float p) {
    return -0.5 * cos(PI * p) + 0.5;
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
