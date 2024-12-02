void drawSine(float t_, float per, float amp, float qual, float len) { // t_ 0 to 1, period length in px, amplitude in px, quality (verticies) per period, length where it should stop
    float lastX = 0;
    float lastY = amp * sin(TWO_PI * (t_ * per) * 1/per);;
    float nextX = lastX + per/qual;
    float nextY = amp * sin(TWO_PI * (nextX + t_ * per) * 1/per);
    while (nextX <= len) {
        line(lastX, lastY, nextX, nextY);
        lastX = nextX;
        lastY = nextY;
        nextX = lastX + per/qual;
        nextY = amp * sin(TWO_PI * (nextX + t_ * per) * 1/per);
    }
}

float period(float t_) {
    return -0.5 * cos(TWO_PI * t_) + 0.5;
}
