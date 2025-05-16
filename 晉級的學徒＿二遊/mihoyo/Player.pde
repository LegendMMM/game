class Player_id {
  PVector XY, speed;
  int     HP, ATK, MAX_HP;
  
  Player_id(PVector XY, PVector speed, int HP, int ATK) {
    this.XY = XY;
    this.speed = speed;
    this.HP = HP;
    this.ATK = ATK;
    this.MAX_HP = HP;      // 初始血量即為最大血量上限
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
    case 4: image(yaling, width/2 + 40, height/2 + 25, 50, 50); 
  // mode5 站著不動時回血
  
    if (weapon_mode % 32 > 15) {
      if (Player_id.speed.x == 0 && Player_id.speed.y == 0) {
        if (frameCount % 60 == 0) {  // 每60幀回復1點血量 (大約每秒)
          Player_id.HP = min(Player_id.HP + 1, Player_id.MAX_HP);
        }
      }
    }break;
  }

  textSize(20);
  textAlign(CENTER);
  if (space_CD > 0) space_CD -= 1;
  text("CD: " + space_CD/60, width/2, height/2 - 50);
  text("HP: " + Player_id.HP, width/2, height/2 + 70);
  
  
  textSize(10);
  textAlign(RIGHT);
  text("XY: " + int(Player_id.XY.x) + ", " + int(Player_id.XY.y), width - 10, height - 30);
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