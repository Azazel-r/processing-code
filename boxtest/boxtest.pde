// Autor: René Richter
// Datum: 18.04.2024
// Zweck: Testen von ASCII rendering

int numFrames = 200;

// VERÄNDERBARE KONSTANTEN
boolean SAVE = false;
String SAVE_AS = ".gif";
boolean LOOP = true;
boolean ASCII = true;
boolean GRAYSCALE = false;
boolean ASCII_CHANGE = false;
color[] boxFarben = new color[] {color(255,0,0),   color(0,255,0),   color(0,0,255),
                                 color(255,255,0), color(255,0,255), color(0,255,255)};

void setup() {
    size(500,500,P3D);
    textAlign(CENTER,CENTER);
    rectMode(CENTER);
    myFont = createFont("Arial", 16);
}

void draw() {
    if (LOOP || frameCount <= numFrames) {
        
        float t = 1.0*(frameCount-1)/numFrames % 1;
        if (ASCII_CHANGE && t == 0) ASCII = !ASCII; // nur zum spaß :P
        
        // siehe definition unten
        predraw(t);
        
        // ASCII render: (siehe anderer processing tab)
        if (ASCII) render_ascii();
        
        if (SAVE) saveFrame("frame###" + SAVE_AS);
    }
}

// hier kommt alles hin was gezeichnet werden soll, vor dem ASCII rendering
void predraw(float t) {
    
    background(0);
    lights();
    push();
    
    // Bunte Box zeichnen
    translate(width/2, height/2);
    rotateX(radians(360*t));
    rotateY(radians(360*t));
    drawBox(boxFarben, 200);
    
    pop();
}


// eigene box() funktion weil die vorhandene alle seiten gleichfarbig macht
void drawBox(color[] cs, float a) {
    
    push();
    noStroke();
    for (int i = 0; i < 3; ++i) {
        
        // sq1
        pushMatrix();
        translate(0,0,a/2);
        if (GRAYSCALE) fill(grayscale(cs[2*i]));
        else fill(cs[2*i]);
        square(0,0,a);
        popMatrix();
        
        // sq2
        pushMatrix();
        translate(0,0,-a/2);
        if (GRAYSCALE) fill(grayscale(cs[2*i + 1]));
        else fill(cs[2*i + 1]);
        square(0,0,a);
        popMatrix();
        
        if (i == 0) rotateX(PI/2);
        else if (i == 1) rotateY(PI/2);
    }
    
    pop();
}


// ------------------

// outtakes (als ich noch mit PShape gearbeitet hab)

/*
(schrecklicher versuch eine pyramide zu erstellen)

class myPyramid {
    
    color[] cs;
    float size;
    
    myPyramid(color[] tcs, float tsize) {
        cs = tcs;
        size = tsize;
    }
    
    // BITTE NOCHMAL ÜBERDENKEN JAAAA
    void drawMe() {
        float l1 = sqrt(3)/2 * size - 1.0 * size/2;
        pg.noStroke();
        pg.push();
        pg.rotateX(radians(90));
        pg.translate(0,0,-l1);
        pg.fill(cs[3]);
        triang();
        pg.pop();
        pg.rotateX(radians(30));
        for (int i = 0; i < 3; ++i) {
            pg.push();
            pg.rotateY(radians(120*i));
            pg.translate(0,0,l1);
            pg.fill(cs[i]);
            triang();
            pg.pop();
        }
        
    }
    
    void triang() {
        float l1 = sqrt(3)/2 * size - 1.0 * size/2;
        pg.triangle(0,-size/2, -size/2,l1, size/2,l1);
    }
    
}

// eigene square funktion weil rectMode(CENTER) (siehe setup funktion) nicht funktionieren will (dreck)
// vllt mach ich das nochmal anders, aber solang benutz ich die hier
PShape mySq(float a, color c) {
    PShape ps;
    ps = createShape();
    ps.setFill(c);
    ps.setStroke(0);
    ps.noStroke();
    ps.beginShape();
    ps.vertex(-a/2,-a/2);
    ps.vertex(a/2,-a/2);
    ps.vertex(a/2,a/2);
    ps.vertex(-a/2,a/2);
    ps.endShape(CLOSE);
    return ps;
}

*/
