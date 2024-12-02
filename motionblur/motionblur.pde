// motion blur template by beesandbombs

int[][] result; // pixel colors buffer for motion blur
float t; // time global variable in [0,1[
float c; // other global variable for testing things, controlled by mouse

void draw()
{
    if (!recording) // test mode...
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
        for (int sa=0; sa<samplesPerFrame; sa++) {
            t = map(frameCount-1 + sa*shutterAngle/samplesPerFrame, 0, numFrames, 0, 1);
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
                int(result[i][0]*1.0/samplesPerFrame) << 16 | 
                int(result[i][1]*1.0/samplesPerFrame) << 8 | 
                int(result[i][2]*1.0/samplesPerFrame);
        updatePixels();
        
        if (frameCount<=numFrames) {
            saveFrame("frames\\fr###.gif");
            println(frameCount,"/",numFrames);
        }
        
        if (frameCount==numFrames)
            exit();
    }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 5;
int numFrames = 50;        
float shutterAngle = 1.2;

boolean recording = true;


void setup(){
    size(800,800);
    result = new int[width*height][3];
    
}


void draw_(){
    
    background(200);
    
    float x = map(-0.5 * cos(TWO_PI * t) + 0.5, 0, 1, 200, 600);
    float y = 400;
    
    fill(0);
    circle(x,y,50);
    
}
