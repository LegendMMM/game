class Player_id {
  PVector XY, speed;
  int     HP, ATK;
  
  Player_id(PVector XY, PVector speed, int HP, int ATK) {
    this.XY = XY;
    this.speed = speed;
    this.HP = HP;
    this.ATK = ATK;
  }
}

Player_id            Player_id = new Player_id(new PVector(0, 0), new PVector(0, 0), 100, 10);

// ─── 畫主角 ───
void DrawPlayer() {
  switch (face) {
    case 0:
      image(playerR, width/2, height/2, 100, 100);
      break;
    case 1:
      image(playerL, width/2, height/2, 100, 100);
      break;
  }
  switch (career) {
    case 0: image(book, width/2 + 40, height/2 + 25, 50, 50); break;
    case 1: image(computer, width/2 + 40, height/2 + 25, 50, 50); break;
    case 2: image(music, width/2 + 40, height/2 + 25, 50, 50); break;
    case 3: image(pen, width/2 + 40, height/2 + 25, 50, 50); break;
    case 4: image(yaling, width/2 + 40, height/2 + 25, 50, 50); break;
  }
  textSize(20);
  textAlign(CENTER);
  text("HP: " + Player_id.HP, width/2, height/2 + 70);
  text("XY: " + int(Player_id.XY.x) + ", " + int(Player_id.XY.y), width/2, height/2 + 90);
}

// ─── 鍵盤事件 ───
void keyPressed() {
  if (key == 'w' && Player_id.speed.y > -v) Player_id.speed.y -= v;
  if (key == 'a' && Player_id.speed.x > -v) { Player_id.speed.x -= v; face = 1; }
  if (key == 's' && Player_id.speed.y <  v) Player_id.speed.y += v;
  if (key == 'd' && Player_id.speed.x <  v) { Player_id.speed.x += v; face = 0; }
}

void keyReleased() {
  if (key == 'w' && Player_id.speed.y <  v) Player_id.speed.y += v;
  if (key == 'a' && Player_id.speed.x <  v) Player_id.speed.x += v;
  if (key == 's' && Player_id.speed.y > -v) Player_id.speed.y -= v;
  if (key == 'd' && Player_id.speed.x > -v) Player_id.speed.x -= v;
}