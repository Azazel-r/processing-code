// motion blur template by beesandbombs modified by azazel_r

// Autor: Renée Richter
// Datum: 16.03.2025
// Zweck: Wellenanimation

int[][] result; // pixel colors buffer for motion blur
float t; // time global variable in [0,1[
float c; // other global variable for testing things, controlled by mouse

int samples = 5;
int numFrames = 120;       
float shutter = 1.2;
boolean SAVE = true;
String SAVEAS = ".png";

// my shit
OpenSimplexNoise noise = new OpenSimplexNoise(22441);
float Y_MIN = 200;
float Y_MAX = 350;

void setup(){
    size(800,800);
    result = new int[width*height][3];
}

void draw_(){
    
    float radius = 1;
    float deviation = 0.25;
    float foam = 35;
    
    float Y_ADD1 = 300 * period(t); // 150 * period(t);
    float Y_ADD2 = 300 * period((t+0.85) % 1); // 400 * period((t+0.85) % 1);
    
    // yellow background (beach)
    background(220,200,0);
    
    strokeWeight(1);
    for (int i = 0; i < width; ++i) {
        
        float p = map(i, 0, width, 0, 1);
        float noiseval = (float) noise.eval(radius*sin(TWO_PI*p), radius*-cos(TWO_PI*p), deviation*sin(TWO_PI*t), deviation*-cos(TWO_PI*t));
        float y = map(noiseval, -1, 1, Y_MIN + Y_ADD1, Y_MAX + Y_ADD2);
        // draw 1 pixel line of sea foam
        stroke(200,200,230);
        line(i, y, i, y-foam);
        // draw 1 pixel line of water
        stroke(0,50,150);
        line(i, y-foam, i, 0);
        
    }
    
}

float period(float p) {
    return -0.5 * cos(TWO_PI * p) + 0.5;
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
