float[][] M = {{0, 8, 2, 10}, {12, 4, 14, 6}, {3, 11, 1, 9}, {15, 7, 13, 5}};
int N = 4;


void dither() {
    
    loadPixels();
    
    for (int i = 0; i < pixels.length; ++i) {
        
        int j = i / 800;
        color c = pixels[i];
        float r = 255.0 / (0.5 * N); // testweise
        color c_new = nearest_color(map(constrain(grayscale(c) + r * ((M[j % N][i % N] * 1.0 / (N*N)) - 0.5), 0, 255), 0, 255, 0, 1));
        pixels[i] = c_new;
        
    }
    
    updatePixels();
}

color nearest_color(float p) {
    return p < .5 ? color(0) : color(255);
}

int grayscale(color c) {
    return int(.299 * red(c) + .587 * green(c) + .114 * green(c));
}
