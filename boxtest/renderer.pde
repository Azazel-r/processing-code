// String ascii = "MLIiao._ "; // unbenutzt ATM
int X = 80; // buchstaben in X richtung
int Y = 80; // buchstaben in Y richtung
int offset = 5; // offset vom bildschrimrand
color[][] farben = new color[Y][X];
PFont myFont;

// main funktion i guess
void render_ascii() {
    
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
            float x = map(i,0,X-1,offset,width-offset);
            float y = map(j,0,Y-1,offset,height-offset);
            String asciichar = "a"; //String.valueOf(ascii.charAt(int(map(farben[j][i], 0, 255, 0, ascii.length()-1)))); // ändern
            fill(farben[j][i]);
            text(asciichar,x,y);
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
