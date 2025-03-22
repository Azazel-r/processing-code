void secondScreen() {
    
    image(bg, 0, 0);
    
    // first
    float whereIsIt = (pos1[0]-500 + period3(t)*(abs(pos1[0]-pos2[0])+2*500));
    for (int i = 0; i < 18; ++i) {
        float x = map(i, 0, 18-1, pos1[0]+margin, pos2[0]-margin);
        float y = pos1[1];
        float diff = constrain(map(abs(x - whereIsIt), width * 0.5, 0, 0, 1),0,1);
        color c = lerpColor(STAINEDWHITE, ELDENGOLD, colorperiod(diff)); 
        stroke(c);
        fill(c);
        rect(x, y, len, thic);
    }
    
    // second
    whereIsIt = (pos2[1]-350 + period3(t)*(abs(pos2[1]-pos3[1])+2*350));
    for (int i = 0; i < 10; ++i) {
        float x = pos2[0];
        float y = map(i, 0, 10-1, pos2[1]+margin, pos3[1]-margin);
        float diff = constrain(map(abs(y - whereIsIt), height * 0.5, 0, 0, 1),0,1);
        color c = lerpColor(STAINEDWHITE, ELDENGOLD, colorperiod(diff)); 
        stroke(c);
        fill(c);
        rect(x, y, thic, len);
    }
    
    // third
    whereIsIt = (pos3[0]+400 - period3(t)*(abs(pos3[0]-pos4[0])+2*400));
    for (int i = 0; i < 16; ++i) {
        float x = map(i, 0, 16-1, pos3[0]-margin, pos4[0]+margin);
        float y = pos3[1];
        float diff = constrain(map(abs(x - whereIsIt), width * 0.5, 0, 0, 1),0,1);
        color c = lerpColor(STAINEDWHITE, ELDENGOLD, colorperiod(diff)); 
        stroke(c);
        fill(c);
        rect(x, y, len, thic);
    }
    
    // squares
    color c = lerpColor(STAINEDWHITE, ELDENGOLD, 1-period4(t));
    stroke(c);
    fill(c);
    square(pos1[0], pos1[1], sqsize);
    square(pos2[0], pos2[1], sqsize);
    square(pos3[0], pos3[1], sqsize);
    square(pos4[0], pos4[1], sqsize);
    
    
}

void firstScreen() {
    
    // background(LICORICE);
    image(bg, 0, 0);

    for (int i = 0; i < numX; ++i) {
        float x = map(i, 0, numX-1, marginX, width-marginX); // float x = (i+1.0) * width/(numX+1);
        float diffx = min(abs(x - map(period(t), 0, 1, 0, width/2)), abs(x - map(period(t), 0, 1, width, width/2)));
        float diff = map(diffx, width/2, 0, 0, 1);
        
        color c = lerpColor(STAINEDWHITE, ELDENGOLD, colorperiod(diff)); 
        stroke(c);
        fill(c);
        rect(x, height-Y, len, thic);
        rect(x, Y, len, thic);
    }
    for (int i = 0; i < numY; ++i) {
        float y = map(i, 0, numY-1, marginY, height-marginY); //float y = (i+1.0) * height/(numY+1);
        float diffy = min(abs(y - map(period(t), 0, 1, 0, height/2)), abs(y - map(period(t), 0, 1, height, height/2)));
        float diff = map(diffy, height/2, 0, 0, 1);
        
        color c = lerpColor(STAINEDWHITE, ELDENGOLD, colorperiod(diff));
        stroke(c);
        fill(c);
        rect(width-X, y, thic, len);
        rect(X, y, thic, len);
    }
    
    color c = lerpColor(STAINEDWHITE, ELDENGOLD, 1-period(t));
    stroke(c);
    fill(c);
    square(X+sqsize/2, Y+sqsize/2, sqsize);
    square(width-X-sqsize/2, Y+sqsize/2, sqsize);
    square(width-X-sqsize/2, height-Y-sqsize/2, sqsize);
    square(X+sqsize/2, height-Y-sqsize/2, sqsize);
    
}
