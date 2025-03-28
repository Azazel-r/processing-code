// motion blur template by beesandbombs modified by azazel_r

int[][] result; // pixel colors buffer for motion blur
float t; // time global variable in [0,1[
float c; // other global variable for testing things, controlled by mouse

int samples = 30;
int numFrames = 120;        
float shutter = 1.2;
boolean SAVE = true;
String SAVEAS = ".png";


void setup(){
    size(800,800);
    result = new int[width*height][3];
}

void draw_(){
    
    background(200);
    push();
    
    stroke(0);
    strokeWeight(20);
    
    translate(width/2, height/2);
    rotate(period() * 4 * TWO_PI);
    
    for (int i = 0; i < 4; ++i) {
        line(0,0,0,200);
        rotate(0.5 * PI);
    }
    
    pop();
}

float period() {
    return t < 0.5 ?
        (1 - sqrt(1 - pow(2 * t, 2))) / 2 :
        (sqrt(1 - pow(-2 * t + 2, 2)) + 1) / 2;
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
