// motion blur template by beesandbombs modified by azazel_r

// Autor: Renée Richter
// Datum: 
// Zweck: 

int[][] result; // pixel colors buffer for motion blur
float t; // time global variable in [0,1[
float c; // other global variable for testing things, controlled by mouse

int samples = 10;
int numFrames = 300;       
float shutter = 1.2;
boolean SAVE = true;
String SAVEAS = ".png";

color BLUE = color(91, 206, 250);
color PINK = color(245, 169, 184);
color WHITE = color(255);
PImage skeleton;

void setup(){
    size(800,800);
    result = new int[width*height][3];
    skeleton = loadImage("skeletonGuns.png");
    imageMode(CENTER);
}

void draw_(){
    
    background(0);
    
    float t1, t2;
    
    t1 = constrain(map(t, 0, 0.4, 0, 1), 0, 1);
    t2 = constrain(map(t, 0.4, 1, 0, 1), 0, 1);
    
    if (t1 != 1.0) { drawSystem(t1); }
    else {
        drawSystem2(t2);
        if (0.2 < t2 && t2 <= 0.8) {
            float t3 = constrain(map(t2, 0.2, 0.8, 0, 1), 0, 1);
            image(skeleton, width/2, height/2, 500*period2(t3), 500*period2(t3));
        }
    }
    
}

void drawSystem(float t) {
    
    float r1 = 1.0 * width/14;
    float r2 = 1.0 * width/8;
    float r3 = 1.0 * width/6;
    float rr1 = 1.0 * width/16;
    float rr2 = 1.0 * width/4.5;
    float rr3 = 1.0 * width/2.5;
    float angle = 180; //map(t, 0, 1, 0, 360);
    float a1 = period(t);
    float a2 = 1.5 * period(t);
    float a3 = 2 * period(t);
    
    drawCircle(r1, r1, rr1, WHITE, a1 * angle+90);
    drawCircle(r1, r1, rr1, WHITE, a1 * angle+270);
    drawCircle(r2, r2, rr2, PINK, a2 * angle+90);
    drawCircle(r2, r2, rr2, PINK, a2 * angle+270);
    drawCircle(r3, r3, rr3, BLUE, a3 * angle+90);
    drawCircle(r3, r3, rr3, BLUE, a3 * angle+270);
    
}

void drawSystem2(float t) {
    
    float r1 = 1.0 * width/14;
    float r2 = 1.0 * width/8;
    float r3 = 1.0 * width/6;
    float rr1 = 1.0 * width/16;
    float rr2 = 1.0 * width/4.5;
    float rr3 = 1.0 * width/2.5;
    
    float adding = 1500 * period2(t);
    float adding2 = 68 * period2(t);
    
    drawCircle(r1 + adding2, r1 + adding, rr1, WHITE, 90);
    drawCircle(r1 + adding2, r1 + adding, rr1, WHITE, 270);
    drawCircle(r2 + adding2, r2 + adding, rr2, PINK, 90);
    drawCircle(r2 + adding2, r2 + adding, rr2, PINK, 270);
    drawCircle(r3 + adding2, r3 + adding, rr3, BLUE, 90);
    drawCircle(r3 + adding2, r3 + adding, rr3, BLUE, 270);
    
}

void drawCircle(float r, float rr, float r2, color c, float angle) {
    
    push();
    translate(width/2, height/2);
    rotate(radians(angle));
    translate(r2,0);
    stroke(c);
    fill(c);
    ellipse(0,0,r,rr);
    pop();
    
}

float period(float t) {
    return -1 * cos(t * PI) + 1;
    // return t < 0.5 ? 4 * t * t * t : 1 - pow(-2 * t + 2, 3) / 2;
}

float period2(float t) {
    if (t < 0.15) return -(cos(PI * map(t, 0, 0.15, 0, 1)) - 1) / 2;
    else if (t >= 0.85) return (cos(PI * map(t, 0.85, 1, 0, 1)) + 1) / 2;
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
