void hilbertCurve(int n, float len, int rot) { // rot = 1 -> left to right .n | rot = -1 -> right to left n.
    
    if (n == 0) {
        
        if (slow && internalcounter++ > counter) return;
        l(len);
        rotate(PI/2 * rot);
        if (slow && internalcounter++ > counter) return;
        l(len);
        rotate(PI/2 * rot);
        if (slow && internalcounter++ > counter) return;
        l(len);
        
    } else {
        
        // 1
        hilbertCurve(n-1, len, -rot);
        
        if (n % 2 == 1) rotate(PI/2 * rot);
        if (slow && internalcounter++ > counter) return;
        l(len);
        if (n % 2 == 0) rotate(PI/2 * rot);

        // 2
        hilbertCurve(n-1, len, rot);
        
        if (n % 2 == 1) rotate(-PI/2 * rot);
        if (slow && internalcounter++ > counter) return;
        l(len);
        if (n % 2 == 1) rotate(-PI/2 * rot);

        // 3
        hilbertCurve(n-1, len, rot);
        
        if (n % 2 == 0) rotate(PI/2 * rot);
        if (slow && internalcounter++ > counter) return;
        l(len);        
        if (n % 2 == 1) rotate(PI/2 * rot);
        
        // 4
        hilbertCurve(n-1, len, -rot);
        
    }
    
}
