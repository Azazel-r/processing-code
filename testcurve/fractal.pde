void fractalCurve(int n, float len, boolean side) { // side = true -> left, side = false -> right
    
    if (n == 0) {
        
        if (side) {
            if (slow && internalcounter++ > counter) return;
            l(len);
            if (slow && internalcounter++ > counter) return;
            rotate(-PI/3);
            l(len);
            if (slow && internalcounter++ > counter) return;
            rotate(-TWO_PI/3);
            l(len);
            if (slow && internalcounter++ > counter) return;
            rotate(PI/3);
            l(len);
            if (slow && internalcounter++ > counter) return;
            rotate(TWO_PI/3);
            l(len);
            if (slow && internalcounter++ > counter) return;
            l(len);
            if (slow && internalcounter++ > counter) return;
            rotate(PI/3);
            l(len);
        } else {
            if (slow && internalcounter++ > counter) return;
            l(len);
            if (slow && internalcounter++ > counter) return;
            rotate(-PI/3);
            l(len);
            if (slow && internalcounter++ > counter) return;
            l(len);
            if (slow && internalcounter++ > counter) return;
            rotate(-TWO_PI/3);
            l(len);
            if (slow && internalcounter++ > counter) return;
            rotate(-PI/3);
            l(len);
            if (slow && internalcounter++ > counter) return;
            rotate(TWO_PI/3);
            l(len);
            if (slow && internalcounter++ > counter) return;
            rotate(PI/3);
            l(len);
        }
        
    } else {
        
        if (side) {
            fractalCurve(n-1, len, true);
            rotate(-PI/3);
            fractalCurve(n-1, len, false);
            rotate(-PI/3);
            fractalCurve(n-1, len, false);
            rotate(PI/3);
            fractalCurve(n-1, len, true);
            rotate(PI/3);
            fractalCurve(n-1, len, true);
            rotate(-PI/3);
            fractalCurve(n-1, len, true);
            rotate(PI/3);
            fractalCurve(n-1, len, false);
        } else {
            fractalCurve(n-1, len, true);
            rotate(-PI/3);
            fractalCurve(n-1, len, false);
            rotate(PI/3);
            fractalCurve(n-1, len, false);
            rotate(-PI/3);
            fractalCurve(n-1, len, false);
            rotate(-PI/3);
            fractalCurve(n-1, len, true);
            rotate(PI/3);
            fractalCurve(n-1, len, true);
            rotate(PI/3);
            fractalCurve(n-1, len, false);
        }
        
    }
    
}
