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