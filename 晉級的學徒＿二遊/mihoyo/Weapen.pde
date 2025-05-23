void mousePressed() {
  switch (career) {
    case 0:
      Weapon_id.add(new Weapon_id(
        new PVector(Player_id.XY.x + width/2, Player_id.XY.y + height/2),
        vector_angle(new PVector(0, 0),
        new PVector(mouseX - width/2, mouseY - height/2)), 15, 300));
      break;
    case 1:
      float randomangle = random(0, 2 * PI);
      Weapon_id_1.add(new Weapon_id_1(
        new PVector(mouseX + Player_id.XY.x - 800 * cos(randomangle) , mouseY + Player_id.XY.y - 800 * sin(randomangle)),
        new PVector(mouseX + Player_id.XY.x, mouseY + Player_id.XY.y),
        randomangle, int(random(0, 10))));
      if (weapon_mode % 32 > 15){ // 隨機攻擊 mode 5
        randomangle = random(0, 2 * PI);
        float randomX = random(-width, width); float randomY = random(-height, height);
        Weapon_id_1.add(new Weapon_id_1(
          new PVector(randomX + Player_id.XY.x - 800 * cos(randomangle) , randomY + Player_id.XY.y - 800 * sin(randomangle)),
          new PVector(randomX + Player_id.XY.x, randomY + Player_id.XY.y),
          randomangle, int(random(0, 10))));
      }
      break;
    case 2:
      break;
    case 3:
      mouseDragged();
      break;
    case 4:
      weapon4.angle = vector_angle(new PVector(0, 0), new PVector(mouseX - width/2, mouseY - height/2)) - PI/3;    
      break;
  }
}
/////////////--------------文------------------------//////////////////
class Weapon_id {
  PVector XY;  float angle, speed, time;
  Weapon_id(PVector XY, float angle, float speed, float time) {
    this.XY = XY; this.angle = angle; this.speed = speed; this.time = time;
  }
}

ArrayList<Weapon_id> Weapon_id = new ArrayList<Weapon_id>();

void DrawWeapon() {
  PVector PXY = new PVector(Player_id.XY.x + width/2, Player_id.XY.y + height/2);

  // mode 1
  if (weapon_mode % 2 == 1 && keyPressed && t % 30 == 0)
    Weapon_id.add(new Weapon_id(new PVector(PXY.x, PXY.y),
                 vector_angle(new PVector(0, 0), Player_id.speed), 15, 300));

  // mode 2
  if (weapon_mode % 4 > 1 && t % 30 == 0 && Monster.size() > 0)
    Weapon_id.add(new Weapon_id(PXY,
                 vector_angle(PXY, Monster.get(int(random(Monster.size()))).XY), 15, 300));

  // mode 3
  if (weapon_mode % 8 > 3 && key == ' ' && keyPressed && space_CD <= 0) {
    for (int i = 0; i < 10; i++)
      Weapon_id.add(new Weapon_id(new PVector(PXY.x, PXY.y),
                   random(0, 2 * PI), 15, 300));
    space_CD = 300;
  }

  // 飛行 & 判定
  for (int i = Weapon_id.size() - 1; i >= 0; i--) {
    Weapon_id w = Weapon_id.get(i);
    w.XY.x += cos(w.angle) * w.speed;
    w.XY.y += sin(w.angle) * w.speed;
    w.time -= 1;
    image(book, w.XY.x, w.XY.y, 100, 100);
    boolean removed = false;
    for (int j = Monster.size() - 1; j >= 0; j--) {
      Monster_id m = Monster.get(j);
      if (vector_length(w.XY, m.XY) < 140 && m.time <= 0) {
        m.HP -= Player_id.ATK;
        if (weapon_mode % 32 > 15) m.time = 17;         // 貫穿
        else { Weapon_id.remove(i); removed = true; break; }
      }
    }
    if (removed) break;

    if (w.time <= 0) {
      if (weapon_mode % 16 > 7 && w.speed != 0) { w.speed = 0; w.time += 300; } // 停留
      else Weapon_id.remove(i);
    }
  }
}

/////////////--------------理------------------------//////////////////
class Weapon_id_1 {
  PVector XY, targetXY;  float angle; int num;
  Weapon_id_1(PVector XY, PVector targetXY, float angle, int num) {
    this.XY = XY; this.targetXY = targetXY; this.angle = angle; this.num = num;
  }
}

ArrayList<Weapon_id_1> Weapon_id_1 = new ArrayList<Weapon_id_1>();

void DrawWeapon_1() {
  textAlign(CENTER);
  for (int i = Weapon_id_1.size() - 1; i >= 0; i--) {
    Weapon_id_1 w = Weapon_id_1.get(i);
    w.XY.x += cos(w.angle) * 50;
    w.XY.y += sin(w.angle) * 50;
    
    noStroke();
    fill(0);
    circle(w.XY.x, w.XY.y, 50);
    fill(0, 255, 0);
    textSize(50);
    text(w.num, w.XY.x, w.XY.y + 20);
    noFill();
    stroke(255, 0, 0);
    strokeWeight(5);
    circle(w.targetXY.x, w.targetXY.y, 50);
    noStroke();
    for (int j = Monster.size() - 1; j >= 0; j--) {
      Monster_id m = Monster.get(j);
      if (vector_length(w.targetXY, m.XY) < 100 && vector_length(w.targetXY, w.XY) < 100) {
        if (weapon_mode % 4 > 1 && w.num == 0) { // 0 變成必殺 mode 2
          m.HP -= m.HP;
        }
        if (weapon_mode % 8 > 3) { // 增加怪物當前血量的一半 mode 3
          m.HP -= int(m.HP/2);
        }
        m.HP -= w.num;
      }
      if (weapon_mode % 2 == 1) { // 路徑傷害 mode 1
        if (vector_length(w.XY, m.XY) < 100) {
          m.HP -= w.num/2 ;
          break;
        }
      }
    }
    if (vector_length(w.XY, w.targetXY) < 100) {
      Weapon_id_1.remove(i);
    }
  }
  fill(255);
  if (weapon_mode % 16 > 7 && keyPressed && key == ' ' && space_CD <= 0) { // 空白鍵將所有數字改為 9 (CD:1) mode 4
    for (int i = Weapon_id_1.size() - 1; i >= 0; i--) {
      Weapon_id_1 w = Weapon_id_1.get(i);
      w.num = 9;
    }
    space_CD = 60;
  }
}


/////////////--------------藝------------------------//////////////////
class Weapon_id_3 {
  PVector XY; float size;
  Weapon_id_3(PVector XY, float size) {
    this.size = size;
    this.XY = XY;
  }
}
float size = 50, R = random(255), G = random(255), B = random(255);
void mouseDragged() {
  size += random(-1, 1); R += random(-1, 1); G += random(-1, 1); B += random(-1, 1);
  if (size < 10) size = 10;
  if (R < 0) R = 0; if (R > 255) R = 255;
  if (G < 0) G = 0; if (G > 255) G = 255;
  if (B < 0) B = 0; if (B > 255) B = 255;
  if (weapon_mode % 16 > 7 && size < 100) size = 100; // mode 4 變大
  Weapon_id_3.add(new Weapon_id_3(
        new PVector(mouseX + Player_id.XY.x, mouseY + Player_id.XY.y), size));
  if (Weapon_id_3.size() > 100 ) {
    if (weapon_mode % 8 > 3){ if (Weapon_id_3.size() > 200 ) Weapon_id_3.remove(0); } // mode 3 變長
    else Weapon_id_3.remove(0);
  }
}

ArrayList<Weapon_id_3> Weapon_id_3 = new ArrayList<Weapon_id_3>();

void DrawWeapon_3() {
  if (mousePressed) mouseDragged();
  for (int i = Weapon_id_3.size() - 1; i >= 0; i--) {
    Weapon_id_3 w = Weapon_id_3.get(i);
    fill(R, G, B);
    noStroke();
    circle(w.XY.x, w.XY.y, w.size);
    fill(255);
    strokeWeight(5);
    for (int j = Monster.size() - 1; j >= 0; j--) {
      Monster_id m = Monster.get(j);
      if (vector_length(w.XY, m.XY) < w.size) {
        w.size -= 1;
        if (weapon_mode % 4 > 1 && m.speed > 1) m.speed = 1; // 減速 mode 2
        if (weapon_mode % 32 > 15){float l = w.XY.dist(m.XY); PVector v = PVector.sub(w.XY, m.XY); v = v.div(l*2); m.XY.add(v); }// 聚怪 mode 5
        m.HP -= int(random(0, 1.1));
      }
    }
  }
  if (weapon_mode % 2 == 1 && keyPressed && key == ' ' && space_CD == 0) { // 時停 mode 1
    for (int i = Monster.size() - 1; i >= 0; i--) {
      Monster_id m = Monster.get(i);
      m.speed = 0;
      space_CD = 600;
    }
  }
}

