//
// Datumn: 21.06.2024
//

float[][] coords;
Tile[] tiles;
int numFrames = 600;
int X = 4;
int Y = 4;

boolean SAVE = true;
String SAVEAS = ".png";

void setup() {
    size(800,800);
    rectMode(CENTER);
    
    coords = new float[Y*X][];
    for (int j = 0; j < Y; ++j) {
        for (int i = 0; i < X; ++i) {
            coords[j*X + i] = new float[] {map(i, 0, X, 100, 850), map(j, 0, Y, 100, 850)};
        }
    }
    
    for (int i = 0; i < X*Y; ++i) {
        int n = floor(random(X*Y));
        float[] temp = coords[n];
        coords[n] = coords[i];
        coords[i] = temp;
    }
    
    tiles = new Tile[coords.length-1];
    for (int i = 0; i < tiles.length; ++i) {
        boolean last = i == tiles.length - 1;
        tiles[i] = new Tile(last);
        tiles[i].makeTs(i, tiles.length+1);
    }
}

void draw() {
    
    background(100);
    
    float t = 1.0 * (frameCount-1) / numFrames % 1;
    
    for (Tile e : tiles) e.drawMe(t);
    
    if (SAVE && frameCount <= numFrames) saveFrame("frames\\frame###" + SAVEAS);
    
}

class Tile {
    
    float t1, t2, t3;
    int queue;
    int r = 50;
    boolean last;
    
    Tile(boolean tlast) {
        last = tlast;
    }
    
    void makeTs(int n, int max) {
        queue = n;
        float length = 1.0 / max;
        t2 = 1 - 1.0 * n / max - length;
        t1 = t2 - length;
        t3 = 1 - length;
    }
    
    void drawMe(float t) {
        
        float[] c1 = coords[queue];
        float[] c2 = coords[queue+1];
        
        if (t < t1) {
            
            square(c1[0], c1[1], r);
            
        } else if (t1 <= t && t < t2) {
            
            float newT = map(t, t1, t2, 0, 1);
            float newX = map(period(newT), 0, 1, c1[0], c2[0]);
            float newY = map(period(newT), 0, 1, c1[1], c2[1]);
            square(newX, newY, r);
            
        } else if (t2 <= t && t < t3) {
            
            square(c2[0], c2[1], r);
            
        } else {
            
            if (last) {
                
                float[] c3 = coords[0];
                float newT = map(t, t3, 1, 0, 1);
                float newX = map(period(newT), 0, 1, c2[0], c3[0]);
                float newY = map(period(newT), 0, 1, c2[1], c3[1]);
                square(newX, newY, r);
                
            } else {
                
                square(c2[0], c2[1], r);
                
            }
        }
        
    }
    
}

float period(float t) {
    return (-cos(PI * t) + 1) / 2; 
}
