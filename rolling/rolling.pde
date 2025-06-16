// motion blur template by beesandbombs modified by azazel_r

// Autor: Renée Richter
// Datum: 
// Zweck: 

int[][] result; // pixel colors buffer for motion blur
float t; // time global variable in [0,1[
float c; // other global variable for testing things, controlled by mouse

int samples = 4;
int numFrames = 50;       
float shutter = 1.2;
boolean SAVE = true;
String SAVEAS = ".gif";
int len = 625;
int deg = 7;

void setup(){
    size(800,800);
    result = new int[width*height][3];
}

void draw_(){
    
    push();
    
    backgradient(color(139,0,160), color(160,0,77), 3);
    for (int i = 0; i < 6; ++i)
    drawBahn(getPos(i), i % 2 == 0 ? 1 : -1);
    
    pop();
    
}

PShape dreieck(int back) {
    float c = len;
    float a = c * sin(radians(deg)) / sin(HALF_PI);
    float b = c * sin(radians(90-deg)) / sin(HALF_PI);
    PShape erg = createShape();
    erg.beginShape();
    erg.fill(0);
    erg.noStroke();
    erg.vertex(0,0);
    erg.vertex(0,a);
    erg.vertex(back*b,a);
    println("a: " + a);
    println("b: " + b);
    erg.endShape(CLOSE);
    return erg;
    
}

void drawBall(float p, int back, int marge) {
    float rad = 30;
    noStroke();
    fill(0);
    if (p < .8) {
        p = map(p, 0, .8, 0, 1);
        float x = p*p * (len-marge);
        float y = -rad * back;
        circle(x,y,rad*2);
        
    } else {
        p = map(p, .8, 1, 0, 1);
        float x = (len-marge) + (90+marge) * period2(p);
        float y = -rad * back + back * 128 * p*p;
        circle(x,y,rad*2);
    }
}

float[] getPos(int i) {
    int Y = -340;
    int Yjump = 213;
    int X1 = 0;
    int X2 = 800;
    return new float[] {i % 2 == 0 ? X1 : X2, Y + Yjump*i};
}

void drawBahn(float[] pos, int back) {
    int marge = 50;
    int K = 3;
    push();
    translate(pos[0],pos[1]);
    shape(dreieck(back), 0, 0);
    rotate(back == 1 ? radians(deg) : PI - radians(deg));
    translate(marge,0);
    for (int i = 0; i < K; ++i) {
        float p = 1.0 * (i+t)/K;
        drawBall(p, back, marge);
    }
    pop();
}

void backgradient(color c1, color c2, int n) {
    pushStyle();
    strokeWeight(1);
    for (int j = 0; j < n; ++j) {
        int start = int(1.0*j/n * height);
        int end = int(1.0*(j+1)/n * height);
        for (int i = start; i < end; ++i) {
            stroke(lerpColor(c1, c2, period(map(i, start, end, 0, 1) + t) % 1));
            line(0,i,width,i);
        }
    }
    popStyle();
}

float period(float p) {
    return -0.5 * cos(TWO_PI * p) + 0.5;
}

float period2(float p) {
    return 1 - (1-p) * (1-p);
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
