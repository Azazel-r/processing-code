// Autor: Renée Richter
// Datum: 13.07.2024
// Zweck: Motion blut test juhuu von dave whyte aka beesandbombs

int numFrames = 60;
int samples = 5;
int[][] result;
String SAVEAS = ".gif";

void setup() {
    size(800,800);
    result = new int[width*height][3];
    reset();
    
}

void reset() {
    for (int i = 0; i < result.length; ++i) {
        result[i] = new int[] {0,0,0};
    }
}

float getT(float frame) {
    return -0.5 * cos(PI*map(frame % numFrames, 0, numFrames, 0, 1)) + 0.5;
}

void draw() {
    
    //float t = 1.0 * (frameCount-1)/numFrames % 1;
    //t = -0.5 * cos(PI*t) + 0.5;
    
    //float t = getT(frameCount-1);
        
    for (int sa = 0; sa < samples; ++sa) {
        
        float newT = getT(frameCount-1 + 1.0*sa/samples);
        background(200);
        
        float x = map( sin(TWO_PI * newT), -1, 1, 200, 600);
        float y = map(-cos(TWO_PI * newT), -1, 1, 200, 600);
        
        fill(0);
        circle(x,y,50);
        
        loadPixels();
        for (int i = 0; i < pixels.length; ++i) {
            result[i][0] += red  (pixels[i]);
            result[i][1] += green(pixels[i]);
            result[i][2] += blue (pixels[i]);
        }
    }
    
    loadPixels();
    for (int i=0; i<pixels.length; i++)
        pixels[i] = 0xff << 24 | 
            int(result[i][0]*1.0/samples) << 16 | 
            int(result[i][1]*1.0/samples) << 8 | 
            int(result[i][2]*1.0/samples);
    updatePixels();
    
    reset();
    
    if (frameCount <= numFrames) saveFrame("frames\\frame###" + SAVEAS);
    else exit();
    
}
