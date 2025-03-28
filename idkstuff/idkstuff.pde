// motion blur template by beesandbombs modified by azazel_r

// Autor: Renée Richter
// Datum: irgendwann Januar 2025
// Zweck: noisy circle

int[][] result; // pixel colors buffer for motion blur
float t; // time global variable in [0,1[
float c; // other global variable for testing things, controlled by mouse

int samples = 10;
int numFrames = 180;       
float shutter = 1.2;
boolean SAVE = true;
String SAVEAS = ".png";
OpenSimplexNoise noise;
int N = 100;
float rad = 1.0;
float zoom = 1.5;
float maxout;

void setup(){
    size(800,800);
    result = new int[width*height][3];
    noise = new OpenSimplexNoise(221);
    maxout = width/2;
}

void draw_(){
    
    float[] points = new float[2*N];
    push();
    stroke(255);
    background(0);
    translate(width/2, height/2);
    
    for (int i = 0; i < N; ++i) {
        
        float d = maxout * constrain(period(map((float) noise.eval(rad*sin(TWO_PI*t), rad*cos(TWO_PI*t), zoom*sin(1.0 * i/N * TWO_PI), zoom*cos(1.0 * i/N * TWO_PI)), -0.66, 0.66, 0, 1)),0.6,1);
        
        float x = d *  sin(TWO_PI*i/N);
        float y = d * -cos(TWO_PI*i/N);
        points[2*i]   = x;
        points[2*i+1] = y;
        
        //rotate(TWO_PI * 1.0/N);
        
    }
    
    for (int i = 0; i < points.length; i += 2) {
        
        float x1 = points[i];
        float y1 = points[i+1];
        float x2 = points[(i+2) % points.length];
        float y2 = points[(i+3) % points.length];
        float d = period(constrain(map(dist(x1,y1,x2,y2), 0, 110000.0/(N*N), 0, 1),0,1));
        float thickness = 5; // map(d, 0, 1, 15, 0);
        strokeWeight(thickness);
        stroke(lerpColor(color(255,0,0), color(0,0,255), d));
        line(x1,y1,x2,y2);
        
        //point(x1,y1);
        //oint(x2,y2);
        
    }
    
    pop();
    
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
