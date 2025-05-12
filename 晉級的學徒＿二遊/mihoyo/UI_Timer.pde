void RunTimer() {
    t += 1;
    if (t > 59) { T += 1; t = 0; }
    image(timer, width/2 - 25, 25, 50, 50);
    textAlign(LEFT); textSize(50); text(T, width/2, 50);
}