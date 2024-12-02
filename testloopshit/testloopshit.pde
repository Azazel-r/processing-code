Windmill w;
Wind wind1, wind2, wind3, wind4, wind5, wind6;
int numFrames = 240;
boolean SAVE = true;

void setup() {
    size(500,500);
    w = new Windmill(4, 200, color(255));
    wind1 = new Wind(0.25 * height, 0, 200, 20);
    wind2 = new Wind(0.36 * height, 0, 120, 50);
    wind3 = new Wind(0.45 * height, 0, 310, 80);
    wind4 = new Wind(0.57 * height, 0, 250, 0);
    wind5 = new Wind(0.67 * height, 0, 145, 25);
    wind6 = new Wind(0.75 * height, 0, 50, 200);
}

void draw() {
    if (frameCount <= numFrames) {
        pushMatrix();
        translate(width/2, height/2);
        background(0);
        float t = 1.0*(frameCount-1)/numFrames % 1;
        w.drawMe(t);
        popMatrix();
        wind1.drawMe(t);
        wind2.drawMe(t);
        wind3.drawMe(t);
        wind4.drawMe(t);
        wind5.drawMe(t);
        wind6.drawMe(t);
        if (SAVE) saveFrame("frame###.gif");
    }
    
}

float speed(float p) {
    return map(-cos(TWO_PI*p),-1,1,0,1);
}

float xWind(float p, int len, int space) {
    return map(p,0,1,width+space,-len-space);
}

class Wind {
    float y;
    int amp;
    int len;
    int offset;
    
    Wind(float ty, int tamp, int tlen, int toffset) {
        y = ty;
        amp = tamp;
        len = tlen;
        offset = toffset;
    }
    
    void drawMe(float p) {
        float x = xWind(p, len, offset);
        stroke(200);
        strokeWeight(3);
        line(x,y,x+len,y);
    }
    
}

class Windmill {
    Rotor rotor;
    int n;
    float rot;
    int size;
    
    Windmill(int tn, int tsize, color tc) {
        rotor = new Rotor(tsize, tc);
        n = tn;
        rot = 0;
        size = tsize;
    }
    
    void drawMe(float p) {
        drawMill();
        rot -= speed(p) * 6 % 90;
        pushMatrix();
        rotate(radians(rot));
        for (int i = 0; i < n; i++) {
            rotor.drawMe();
            rotor.rotateMe(360/n);
        }
        popMatrix();
    }
    
    void drawMill() {
        fill(0);
        stroke(255);
        strokeWeight(2);
        PShape body = createShape();
        body.beginShape();
        body.vertex(-0.4 * size, 0.2 * size);
        body.vertex(0.4 * size, 0.2 * size);
        body.vertex(0.6 * size, height);
        body.vertex(-0.6 * size, height);
        body.endShape(CLOSE);
        shape(body, 0, 0);
        //ellipse(0,0,0.66*size,0.5*size);
        PShape roof = createShape();
        roof.beginShape(TRIANGLES);
        roof.vertex(-0.4 * size, 0.2 * size);
        roof.vertex(0.4 * size, 0.2 * size);
        roof.vertex(0, -0.3 * size);
        roof.endShape();
        shape(roof, 0, 0);
    }
}

class Rotor {
    
    int size;
    color c;
    float angle;
    
    Rotor(int tsize, color tc) {
        size = tsize;
        c = tc;
        angle = 0;
    }
    
    void rotateMe(float a) {
        angle += a;
        angle %= 360;
    }
    
    void drawMe() {
        strokeWeight(2);
        stroke(c);
        fill(0);
        pushMatrix();
        rotate(radians(angle));
        line(0,0,0,-size);
        rect(0,-size,size*0.2,size*0.8);
        // triangle thingys
        /*
        float sA, sB, sC, alpha;
        alpha = 70;
        sC = size * 0.8;
        sA = sin(radians(alpha)) * sC;
        sB = cos(radians(alpha)) * sC;
        PShape p = createShape();
        p.beginShape(TRIANGLES);
        p.vertex(0,-size);
        p.vertex(0,-0.2 * size);
        p.vertex(sqrt((pow(sA, 2)/sC) * (pow(sB, 2)/sC)), -0.2*size - pow(sB, 2)/sC);
        p.endShape();
        strokeWeight(2);
        stroke(c);
        fill(0);
        shape(p, 0, 0);
        */
        popMatrix();
    }
    
}
