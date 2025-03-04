// motion blur template by beesandbombs modified by azazel_r

int[][] result; // pixel colors buffer for motion blur
float t; // time global variable in [0,1[
float c; // other global variable for testing things, controlled by mouse

int samples = 4;
int numFrames = 200;        
float shutter = 1.2;
boolean SAVE = true;
String SAVEAS = ".gif";
color LICORICE = #1a1110;
color STAINEDWHITE = #e5eeef;
color ELDENGOLD = #bd6707;
// UNUSED COLORS #f1d16c #f9c043
float X = 66;
float Y = 26;
int thic = 2;
int numX = 22;
int numY = 14;
float sqsize = 18;
float len;
float margin;
float marginX;
float marginY;
PImage bg;
float[] pos1 = {325,   25};
float[] pos2 = {1895,  25};
float[] pos3 = {1895, 947};
float[] pos4 = {538,  947};

void setup(){
    fullScreen();
    result = new int[width*height][3];
    rectMode(CENTER);
    println(len);
    len = 1.0 * width / (2*numX);
    margin = sqsize*3 + len/2;
    marginX = X + margin;
    marginY = Y + margin;
    bg = loadImage("background.png");
}

void draw_(){
    
    push();
    
    secondScreen();
    
    pop();
    
}

float period4(float p) { // used for screen 2 squares
    if (p < .3) return 0;
    else return -0.5 * cos(TWO_PI * map(p, .3, 1, 0, 1)) + 0.5;
}

float period3(float p) { // used for screen 2
    if (p < .3) return 0;
    else return -0.5 * cos(PI * map(p, .3, 1, 0, 1)) + 0.5;
}

float period2(float p) { // unused
    if (p < .2 || p >= .8) return 0;
    p = map(p, 0.2, 0.8, 0, 1);
    return -0.5 * cos(TWO_PI*p) + 0.5;
}

float period(float p) { // used for screen 1
    if (p < .1) return 0;
    else if (.1 <= p && p < .5) return -0.5 * cos(PI*map(p, .1, .5, 0, 1)) + 0.5;
    else if (.5 <= p && p < .6) return 1;
    else return -0.5 * cos(PI*map(p, .6, 1, 0, 1) + PI) + 0.5;
}

float colorperiod(float p) { // used for both screens
    return 1 - cos(0.5 * p * PI);
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
