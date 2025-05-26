// motion blur template by beesandbombs modified by azazel_r

// Autor: Renée Richter
// Datum: 
// Zweck: 

int[][] result; // pixel colors buffer for motion blur
float t; // time global variable in [0,1[
float c; // other global variable for testing things, controlled by mouse

int samples = 4;
int numFrames = 100;       
float shutter = 1.2;
boolean SAVE = true;
String SAVEAS = ".gif";
int len = 625;
int deg = 7;
float[] pos1 = {50,75};
float[] pos2 = {750, 275};

void setup(){
    size(800,800);
    result = new int[width*height][3];
}

void draw_(){
    
    push();
    
    background(200);
    for (int i = 0; i < 6; ++i)
    drawBahn(getPos(i), i % 2 == 0 ? 1 : -1);
    
    pop();
    
}

void drawBall(float p, int back) {
    float rad = 30;
    if (p < .8) {
        p = map(p, 0, .8, 0, 1);
        float x = p * len;
        float y = -rad * back;
        circle(x,y,rad*2);
        
    } else {
        p = map(p, .8, 1, 0, 1);
        float x = len + 90 * p;
        float y = -rad * back + back * 130 * p;
        circle(x,y,rad*2);
    }
}

float[] getPos(int i) {
    int Y = -350;
    int Yjump = 213;
    int X1 = 50;
    int X2 = 750;
    return new float[] {i % 2 == 0 ? X1 : X2, Y + Yjump*i};
}

void drawBahn(float[] pos, int back) {
    push();
    translate(pos[0],pos[1]);
    rotate(back == 1 ? radians(deg) : PI - radians(deg));
    line(0,0,len,0);
    drawBall(t, back);
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
