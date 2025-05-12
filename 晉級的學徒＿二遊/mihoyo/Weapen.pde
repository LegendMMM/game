class Weapon_id {
  PVector XY;  float angle, speed, time;
  Weapon_id(PVector XY, float angle, float speed, float time) {
    this.XY = XY; this.angle = angle; this.speed = speed; this.time = time;
  }
}

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
  if (weapon_mode % 8 > 3 && key == ' ' && keyPressed && mode3_CD <= 0) {
    for (int i = 0; i < 10; i++)
      Weapon_id.add(new Weapon_id(new PVector(PXY.x, PXY.y),
                   random(0, 2 * PI), 15, 300));
    mode3_CD = 300;
  }
  mode3_CD -= 1;

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
      if (m.HP <= 0) { Monster.remove(j); credit += 1; }
    }
    if (removed) break;

    if (w.time <= 0) {
      if (weapon_mode % 16 > 7 && w.speed != 0) { w.speed = 0; w.time += 300; } // 停留
      else Weapon_id.remove(i);
    }
  }
}

void mousePressed() {
  Weapon_id.add(new Weapon_id(
    new PVector(Player_id.XY.x + width/2, Player_id.XY.y + height/2),
    vector_angle(new PVector(0, 0),
    new PVector(mouseX - width/2, mouseY - height/2)), 15, 300));
}