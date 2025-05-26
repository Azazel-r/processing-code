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
int n_row = 10;
float d = 200;

void setup(){
    size(800,800);
    result = new int[width*height][3];
}

void draw_(){
    
    
    background(150,190,240);
    noStroke();
    fill(50,90,140);
    rect(0,height/2,width,height/2);
    
    
    noStroke();
    push();
    translate(0, height/2);
    
    for (int i = 0; i < n_row; ++i) {
        
        float p = 1.0 * (i+(1-period(t)))/n_row;
        float pnot = 1.0 * (i+1)/n_row;
        push();
        fill(255);
        myTriang(p, pnot, 1);
        pop();
        fill(200);
        myTriang(p, pnot, -1);
        
    }
    pop();
    
    
}

void myTriang(float p, float pnot, int fact) {
    
    float d_ = d * p;
    float d__ = d * pnot;
    push();
    rotate(period(t) * fact * -0.33 * TWO_PI);
    triangle(0,0,d_,0,d_/2,fact * -sqrt(pow(d_,2)-pow(d_/2,2)));
    pop();
    translate(d__,0);
    
}

float period(float p){
    return p*p*p;
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
