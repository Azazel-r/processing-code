String ascii = " .,_-cadbLON@#"; // "Ñ@#W$9876543210?!abc;:+=-,._ "; // 
int X; // buchstaben in X richtung
int Y; // buchstaben in Y richtung
int offset = 20; // offset vom bildschrimrand
float abstand = 15;
color[][] farben;
PFont myFont;
boolean plain_bw = false;

// einmal in der setup funktion callen
void setup_ascii() {
    X = int(width/abstand);
    Y = int(height/abstand);
    farben = new color[Y][X];
    myFont = createFont("Arial", int(abstand * 7/5));
    textAlign(CENTER,CENTER);
}

// main funktion i guess
void render_ascii(color bg) {
    
    // farben vom bildschrim getten und speichern in nem array
    for (int i = 0; i < X; ++i) {
        for (int j = 0; j < Y; ++j) {
            float x = map(i,0,X-1,offset,width-offset);
            float y = map(j,0,Y-1,offset,height-offset);
            farben[j][i] = get(int(x),int(y));
        }
    }
    
    // zeichen rendern
    textFont(myFont);
    background(0);
    for (int i = 0; i < X; ++i) {
        for (int j = 0; j < Y; ++j) {
            if (farben[j][i] != bg) {
                float x = map(i,0,X-1,offset,width-offset);
                float y = map(j,0,Y-1,offset,height-offset);
                if (plain_bw) {
                    char asciichar = ascii.charAt(int(map(grayscale(farben[j][i]), 0, 255, 0, ascii.length()-1))); // ändern
                    fill(255);
                    text(asciichar,x,y);
                } else {
                    char asciichar = 'a'; //String.valueOf(ascii.charAt(int(map(farben[j][i], 0, 255, 0, ascii.length()-1)))); // ändern
                    fill(farben[j][i]);
                    text(asciichar,x,y);
                }
                
            }
        }
    }
}


// funktion die ich zum testen benutzt hab idk (nur aus irgendeinem forum post kopiert)
int grayscale(color c) {
    int r = (c >> 16) & 0xFF;
    int g = (c >> 8) & 0xFF;
    int b = c & 0xFF;
    return (int(0.299*r + 0.587 * g + 0.114 * b));
}
