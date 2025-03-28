// motion blur template by beesandbombs modified by azazel_r

// Autor: Renée Richter
// Datum: 21.03.2025
// Zweck: first test of dithered animation

int[][] result; // pixel colors buffer for motion blur
float t; // time global variable in [0,1[
float c; // other global variable for testing things, controlled by mouse

int samples = 4;
int numFrames = 300;       
float shutter = 1.2;
boolean SAVE = true;
String SAVEAS = ".png";
//
float rad = 300;
float sphere_rad = 15;
int NUM = 12;
color[] cols = {color(0,200,0), color(200,200,0)};
OpenSimplexNoise noise = new OpenSimplexNoise(22441);
float zoom = 0.1;

void setup(){
    size(800,800,P3D);
    result = new int[width*height][3];
    sphereDetail(15);
}

void draw_(){
    
    push();
    
    lights();
    background(0);
    
    // box
    translate(width/2, height/2);
    rotateX(radians(-30));
    pushMatrix();
    rotateY(TWO_PI * period2(t));
    noStroke();
    fill(lerpColor(color(0,0,0,0), color(200), period(t)));
    if (.25 <= t && t < .75) box(150);
    popMatrix();
    
    // spheres
    for (int i = 0; i < NUM; ++i) {
        pushMatrix();
        fill(lerpColor(cols[i % 2], color(0,0,0,0), period(t)));
        // noise
        rotateX(TWO_PI * period2((map((float) noise.eval(10 * (i+1) + zoom*sin(TWO_PI * t), 10 * (i+1) + zoom*cos(TWO_PI * t)), -0.66, 0.66, 0, 1) + .5) % 1));
        rotateY(TWO_PI * period2((map((float) noise.eval(20 * (i+1) + zoom*sin(TWO_PI * t), 20 * (i+1) + zoom*cos(TWO_PI * t)), -0.66, 0.66, 0, 1) + .5) % 1));
        rotateZ(TWO_PI * period2((map((float) noise.eval(30 * (i+1) + zoom*sin(TWO_PI * t), 30 * (i+1) + zoom*cos(TWO_PI * t)), -0.66, 0.66, 0, 1) + .5) % 1));
        float x =  sin(TWO_PI * i / NUM + TWO_PI * period2((t+.5) % 1)) * rad;
        float z = -cos(TWO_PI * i / NUM + TWO_PI * period2((t+.5) % 1)) * rad;
        translate(x, 0, z);
        sphere(sphere_rad);
        popMatrix();
    }
    
    dither();
    
    pop();
    
}

// sine [0 - 1 - ]
float period(float p) {
    return -0.5 * cos(TWO_PI * p) + 0.5;
}

// sine [0 - 1]
float period2(float p) {
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
