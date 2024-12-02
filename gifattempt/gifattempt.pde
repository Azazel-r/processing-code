PFont f;
float r = 200;
float numFrames = 200;
int i = 0;

void setup() {
    size(800,800);
    f = createFont("Consolas", 32);
    textFont(f);
    textAlign(CENTER, CENTER);
    fill(0);
}


void draw() {
    
    background(177);
    
    float tMax = 2*i/numFrames;
    
    if ((int) tMax == 0) { // erste umdrehung, alles is schwarz und weiße 0en werden gezeichnet
    
        for (float t = 0; t < tMax; t += (2/numFrames)) {
      
            float x = width/2 + r*sin(TWO_PI*t);
            float y = height/2 - r*cos(TWO_PI*t);
            
            fill(255);
            text('0', x, y);
        }
        
        for (float t = tMax; t <= 1; t += (2/numFrames)) {
            
            float x = width/2 + r*sin(TWO_PI*t);
            float y = height/2 - r*cos(TWO_PI*t);
            
            fill(0);
            text('0', x, y);
        }
        
    } else if ((int) tMax == 1) {
        
        for (float t = 1; t < tMax; t += (2/numFrames)) {
      
            float x = width/2 + r*sin(TWO_PI*t);
            float y = height/2 - r*cos(TWO_PI*t);
            
            fill(0);
            text('0', x, y);
        }
        
        for (float t = tMax; t <= 2; t += (2/numFrames)) {
            
            float x = width/2 + r*sin(TWO_PI*t);
            float y = height/2 - r*cos(TWO_PI*t);
            
            fill(255);
            text('0', x, y);
        }
    }
    
    if (frameCount <= numFrames) saveFrame("frame###.png");
    
    i++;
    i %= 200;
}
