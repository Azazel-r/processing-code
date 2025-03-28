// motion blur template by beesandbombs modified by azazel_r

// Autor: Renée Richter
// Datum: 31.08.2024
// Zweck: Tetris Block Animation

int[][] result; // pixel colors buffer for motion blur
float t; // time global variable in [0,1[
float c; // other global variable for testing things, controlled by mouse

int samples = 10;
int numFrames = 420;
float shutter = 1.2;
boolean SAVE = true;
String SAVEAS = ".png";
int rad = 150;
color[] BGs = new color[] {color(100,100,0), color(0,100,100), color(100,0,100), color(0,100,0), color(100,0,0), color(100,50,0), color(0,0,100)};

void setup(){
    size(800,800);
    result = new int[width*height][3];
}

void draw_(){
    
    int segment = floor(map(t, 0, 1, 0, 7));
    float miniT = t * 7 % 1;
    background(lerpColor(color(0), BGs[segment], period(miniT)));
    
    drawShape(segment, miniT);
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
