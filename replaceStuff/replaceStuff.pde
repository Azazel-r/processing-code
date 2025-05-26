// motion blur template by beesandbombs modified by azalea_r

// Autor: Renée Richter
// Datum: 
// Zweck: 

int[][] result; // pixel colors buffer for motion blur
float t; // time global variable in [0,1[
float c; // other global variable for testing things, controlled by mouse

int samples = 1;
int numFrames = 250;
float shutter = 1.2;
boolean SAVE = false;
String SAVEAS = ".gif";
int K = 20;
color[] trans = {#5BCEFA, #5BCEFA, #5BCEFA, #F5A9B8, #FFFFFF, #F5A9B8, #5BCEFA};
Tile[][] tiles = new Tile[5][2];
int L = 500;
int timefactor = 5;

void setup(){
    size(800,800);
    result = new int[width*height][3];
    rectMode(CENTER);
    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 5; ++j)
    tiles[j][i] = new Tile(i,j);
}

void draw_(){
    
    background(0);
    
    push();
    translate(0, -0.33 * tiles.length * L);
    
    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 5; ++j)
    tiles[j][i].show();
    
    pop();
}

class Tile {
    
    int xIndex, yIndex;
    
    Tile(int i, int j) {
        xIndex = i;
        yIndex = j;
    }
    
    void show(float p) {
        for (int i = 0; i < K; ++i) {
            float p2 = (1.0*(i+(timefactor*t%1))/K) % 1;
            push();
            translate(L*xIndex, L*yIndex);
            translate(-p*L*2, -p*L);
            float l = L * period3(p2);
            noFill();
            stroke(lerpColor(#ffff00, #ff0000, period2(p2)));
            strokeWeight(2);
            square(0,0,l);
            pop();
        }
    }
    
    void show() {
        int repeats = 5;
        for (int i = -repeats; i <= repeats; ++i) {
            float p = i + t;
            show(p);
        }
    }
        
        
}

float period2(float p) {
    return -0.5 * cos(PI * p) + 0.5;
}

float period3(float p) {
    return sin(0.5 * p * PI);
}

color lerpColors(float p, color... colors) {
  if (colors.length == 1) return colors[0];
  if (colors.length == 2) return lerpColor(colors[0], colors[1], p);
  
  
  float scaledTime = p * (float)(colors.length - 1);
  println(p, scaledTime);
  color oldColor = colors[(int)scaledTime];
  color newColor = colors[(int)(scaledTime + 1f)];
  
  float newT = scaledTime - floor(scaledTime); 
  
  return lerpColor(oldColor, newColor, newT);
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
