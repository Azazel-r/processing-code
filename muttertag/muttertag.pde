// Autor: René Richter
// Datum: 11.05.2024
// Zweck: Muttertag

PImage heart, star;
int numFrames = 200;
boolean SAVE = true;
String SAVEAS = ".png";
String frohen = "Frohen";
String muttertag = "Muttertag!";
String vonmir = "(von René)";
PFont myFont, myFont2;

void setup() {
    size(800,800,P3D);
    heart = loadImage("heart300.png");
    star = loadImage("star100.png");
    imageMode(CENTER);
    myFont = createFont("GreatVibes-Regular.ttf", 72);
    myFont2 = createFont("Segoe Print", 24);
    textAlign(CENTER, CENTER);
    strokeCap(PROJECT);
    
}

void draw() {
    
    float t = 1.0 * (frameCount-1) / numFrames % 1;
    background(255,180,255);
    
    drawStar(200,100,t,0);
    drawStar(400,80,t,0.2);
    drawStar(600,100,t,0.4);
    drawStar(200,700,t,0.6);
    drawStar(600,700,t,0.8);
    
    
    push();
    drawHeartbeat(t, 100);
    translate(width, height);
    rotate(PI);
    drawHeartbeat(t, 100);
    pop();
    
    drawSchrift(); //<>//
    
    translate(width/2, height/2);
    
    rotateY(rot(t));
    
    image(heart,0,0);
    
    if (frameCount <= numFrames && SAVE) saveFrame("frames\\frame###" + SAVEAS);
    
}

float rot(float t) {
    return map(-0.5 * cos(PI*t) + 0.5, 0, 1, 0, 4 * TWO_PI);   
}

float rot2(float t) {
    return -0.5 * cos(PI*t) + 0.5;
}

void drawStar(float x, float y, float t, float off) {
    push();
    translate(x,y);
    rotateZ(rot2(constrain(map(t,off,off+.2,0,1),0,1)) * TWO_PI);
    image(star,0,0);
    pop();
}

void drawSchrift() {
    push();
    textFont(myFont);
    fill(255,0,0);
    translate(width/2, height * 0.225);
    text(frohen,0,0);
    translate(0,height * 0.55);
    text(muttertag,0,0);
    translate(0,4.0*height/30);
    pop();
    
    textFont(myFont2);
    fill(180,100,180);
    text(vonmir,width/2,height-75);
}

void drawHeartbeat(float t, float X) {
    
    stroke(255,0,0);
    strokeWeight(5);
    
    float yeah = 1.0 * height/4;
    float yeahh = (1.0 * height/4) * (1.0/7);
    float[] Xs = new float[height];
    
    int Y = floor(map(t, 0, 1, 0, height*2));
    int nachY = Y - height;
    float[] chapters = new float[] {yeah,
                            yeah + yeah * (1.0/7),
                            yeah + yeah * (2.0/7),
                            yeah + yeah * (3.0/7),
                            yeah + yeah * (4.0/7),
                            yeah + yeah * (5.0/7),
                            yeah + yeah * (6.0/7),
                            2 * yeah};

    int index = 0;
    for (float y = nachY; y < Y; ++y) {
        float x = X;
        if (y >= chapters[0]) x = x + 1.5 * yeahh * constrain(map(y, chapters[0], chapters[1], 0, 1), 0, 1);
        if (y >= chapters[1]) x = x - 3   * yeahh * constrain(map(y, chapters[1], chapters[2], 0, 1), 0, 1);
        if (y >= chapters[2]) x = x + 6.5 * yeahh * constrain(map(y, chapters[2], chapters[3], 0, 1), 0, 1);
        if (y >= chapters[3]) x = x - 5   * yeahh * constrain(map(y, chapters[3], chapters[4], 0, 1), 0, 1);
        if (y >= chapters[4]) x = x - 2.5 * yeahh * constrain(map(y, chapters[4], chapters[5], 0, 1), 0, 1);
        if (y >= chapters[5]) x = x + 3.5 * yeahh * constrain(map(y, chapters[5], chapters[6], 0, 1), 0, 1);
        if (y >= chapters[6]) x = x - 1   * yeahh * constrain(map(y, chapters[6], chapters[7], 0, 1), 0, 1);
        if (y >= chapters[7]) x = X;
        Xs[index] = x;
        index++;
    }

    
    index = 0;
    for (float y = nachY; y < Y-1; ++y) {
        line(Xs[index], y, Xs[index+1], y+1);
        index++;
    }
    
}
