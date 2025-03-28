// Autor: Renée Richter
// Datum: 04.07.2024
// Zweck: Isometric Pillars up n down

int numFrames = 240;
float[] points = new float[] {0,0,300,0,300,300,0,300};
int boxWidth = 25;
int[] numberOf = new int[] {12,12,12,12};
float all = sum(numberOf);
boolean SAVE = true;
String SAVEAS = ".png";

// colors
color RED = color(200,0,0);
color YELLOW = color(200,200,0);
color GREEN = color(0,200,0);
color CYAN = color(0,200,200);
color BLUE = color(0,0,200);
color PURPLE = color(200,0,200);
color LIGHTBLUE = color(91, 206, 250);
color PINK = color(245, 169, 184);
color WHITE = color(255);

void setup() {
    size(800,800,P3D);
    ortho();
}

void draw() {
    
    lights();
    
    background(0);
    float t = 1.0 * (frameCount-1) / numFrames % 1;
    
    translate(width/2, height/2);
    rotateX(PI/4);
    //rotateY(PI/4);
    rotateZ(PI/4);
    
    int count = 0;
    noStroke();
    
    
    for (int i = 0; i < points.length/2; ++i) {
        for (int j = 0; j < numberOf[i]; ++j) {
            //if (j == numberOf[i]-1) continue;
            float newT = (t + map(count++, 0, all+1, 0, 1)) % 1;
            float heightVal = period(newT, 0, 300);
            color myCol = lerpColors(newT, RED, YELLOW, GREEN, CYAN, BLUE, PURPLE, RED, RED, YELLOW, GREEN, CYAN, BLUE, PURPLE, RED); // rainbow
            // color myCol = lerpColors(newT, WHITE, PINK, LIGHTBLUE, PINK, WHITE, WHITE, PINK, LIGHTBLUE, PINK, WHITE); // trans
            
            float startX = points[i*2];
            float startY = points[i*2 + 1];
            float endX = points[((i+1) * 2) % points.length];
            float endY = points[((i+1) * 2 + 1) % points.length];
            //println("Go from X: " + startX + " Y: " + startY + " | to X: " + endX + " Y: " + endY);
            float x = map(j, 0, numberOf[i], startX, endX);
            float z = map(j, 0, numberOf[i], startY, endY);
            
            push();
            translate(x,z);
            fill(myCol);
            myBox(boxWidth, boxWidth, heightVal);
            pop();
        }
    }
    
    if (SAVE && frameCount <= numFrames) saveFrame("frames\\frame###" + SAVEAS);
    
}

float period(float t, float min, float max) {
    // return map(-cos(TWO_PI * t)/2 + 0.5, 0, 1, min, max);
    return map(-cos(6* PI * t)/2 + 0.5, 0, 1, min, max);
}

void myBox(float w, float h, float d) {
    pushMatrix();
    translate(0, 0, d/2);
    box(w,h,d);
    popMatrix();
}

int sum(int[] arr) {
    int erg = 0;
    for (int i = 0; i < arr.length; ++i) erg += arr[i];
    return erg;
}

color lerpColors(float p, color ...colors) {
    if (colors.length == 1) return colors[0];
    if (colors.length == 2) return lerpColor(colors[0], colors[1], p);
    
    float idx = p * (colors.length - 1);
    int lowerColor = floor(idx);
    int upperColor = ceil(idx);
    
    float factor = map(p - (1.0 * lowerColor / (colors.length - 1)), 0, 1.0 / (colors.length - 1), 0, 1);
    
    return lerpColor(colors[lowerColor], colors[upperColor], factor);
}
