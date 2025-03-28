// motion blur template by beesandbombs modified by azazel_r

// Autor: Renée Richter
// Datum: 31.08.2024
// Zweck: Bouncy iwas

int[][] result; // pixel colors buffer for motion blur
float t; // time global variable in [0,1[
float c; // other global variable for testing things, controlled by mouse

int samples = 10;
int numFrames = 120;       
float shutter = 1.4;
boolean SAVE = true;
String SAVEAS = ".png";
float rad = 600;

void setup(){
    size(800,800);
    result = new int[width*height][3];
}

void draw_(){
    
    push();
    
    translate(width/2, height/2);
    background(0);
    noStroke();
    
    float t1 = bounce(t*2 % 1);
    
    if (t < .5) {
        fill(255,0,0);
        circle(0,0,rad);
        fill(0);
        circle(0,0,map(t1, 0, 1, rad+5, 0));
    } else {
        fill(255,0,0);
        circle(0,0,map(t1, 0, 1, rad, 0));
    }
    
    pop();
    
}

float bounce(float t_) {
    float n1 = 7.5625;
    float d1 = 2.75;
    
    if (t_ < 1 / d1) {
        return n1 * t_ * t_;
    } else if (t_ < 2 / d1) {
        return n1 * (t_ -= 1.5 / d1) * t_ + 0.75;
    } else if (t_ < 2.5 / d1) {
        return n1 * (t_ -= 2.25 / d1) * t_ + 0.9375;
    } else {
        return n1 * (t_ -= 2.625 / d1) * t_ + 0.984375;
    }
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
