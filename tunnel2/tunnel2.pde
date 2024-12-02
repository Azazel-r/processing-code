// motion blur template by beesandbombs modified by azazel_r

// Autor: Renée Richter
// Datum: 31.08.2024
// Zweck: Tunnel animation 2

int[][] result; // pixel colors buffer for motion blur
float t; // time global variable in [0,1[
float c; // other global variable for testing things, controlled by mouse

int samples = 10;
int numFrames = 200;       
float shutter = 1.2;
boolean SAVE = true;
String SAVEAS = ".gif";
int rotations = 400;
int n = 32;
int size = 500;

void setup(){
    size(800,800);
    result = new int[width*height][3];
    rectMode(CENTER);
}

void draw_(){
    
    background(0);
    push();
    noFill(); // fill(0);
    strokeWeight(2);
    float rad = period2(t) * 400;
    float startx = width/2  + rad *  sin(rotations * TWO_PI * t);
    float starty = height/2 + rad * -cos(rotations * TWO_PI * t);
    
    for (int i = 0; i < n; ++i) {
        float teil = 1.0 * i / n;
        push();
        float x = map(period3(teil), 0, 1, startx, width/2);
        float y = map(period3(teil), 0, 1, starty, height/2);
        stroke(lerpColor(color(255,0,0), color(0,255,0), map(x, 0, width, 0, 1)));
        translate(x, y);
        rotate(teil * PI);
        push();
        rotate(t*TWO_PI);
        square(0,0,size*teil*teil);
        pop();
        pop();
    }
    
    pop();
    
}

// easeInSine 1 - 0
float period(float t_) {
    return cos(0.5 * PI * t_);
}

// easeInOutSine double 0 - 1 - 0
float period2(float t_) {
    return -0.5 * cos(TWO_PI * t_) + 0.5;
}

// easeInOutSine 0 - 1
float period3(float t_) {
    return -0.5 * cos(PI * t_) + 0.5;
}

// easeInOutSine 1 - 0
float period4(float t_) {
    return 0.5 * cos(PI * t_) + 0.5;
}

// easeInCirc 1 - 0
float period5(float t_) {
    return sqrt(1 - pow(1-t_, 2));   
}

float periodRad(float t_) {
    float p1 = .4;
    float p2 = .6;
    if      (t_ < p1)  return period3(map(t_, 0, p1, 0, 1));
    else if (t_ >= p2) return period4(map(t_, p2, 1, 0, 1));
    else return 1;
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
