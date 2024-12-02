// motion blur template by beesandbombs modified by azazel_r

int[][] result; // pixel colors buffer for motion blur
float t; // time global variable in [0,1[
float c; // other global variable for testing things, controlled by mouse

int samples = 10;
int numFrames = 200;        
float shutter = 0.8;
boolean SAVE = false;
String SAVEAS = ".gif";
float[] pos;
float[] vecs;
float X = 0;
float Y = 0;
float d = 550;
int n = 7;

void setup(){
    size(800,800);
    result = new int[width*height][3];
    setup_();
}

void setup_() {
    pos = getSierpPos(X, Y, d/2, n);
    vecs = new float[pos.length];
    for (int i = 0; i < pos.length / 2; ++i) {
        vecs[2*i]   = pos[2*i] - X;
        vecs[2*i+1] = pos[2*i+1] - Y;
    }
    
}

void draw_() {
    
    push();
    
    background(0);
    stroke(255);
    translate(width/2, height/2);
    //point(0,0);
    
    for (int i = 0; i < pos.length/2; ++i) {
        float x = pos[2*i]  ; //+ vecs[2*i]  * 2 * myCurve(t);
        float y = pos[2*i+1]; //+ vecs[2*i+1]* 2 * myCurve(t);
        float distFactor = 2 * easeInSine(map(dist(x,y,X,Y), 0, 1000, 0, 1));
        pushMatrix();
        rotate(2 * TWO_PI * myCurve(t) * distFactor);
        newTri(x, y, d/2, n);
        popMatrix();
        
    }
    
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
