/////////////--------------體------------------------//////////////////
class Weapon_id_4 {
  float angle, speed, cd, time;
  PVector XY;
  float mode4_cd;
  int size;
  
  Weapon_id_4() {
    this.angle = 0;
    this.speed = 10; this.cd = 0; this.time = 0; this.mode4_cd = 0; this.size = 0;
    this.XY = new PVector(0, 0);
  }
}
Weapon_id_4 weapon4 = new Weapon_id_4();

//1 攻擊擊退
//2 空白鍵向前衝刺 消滅路進上敵人
//3 加大啞鈴
//4 給怪物上dot
//5 站著時每秒回一滴血
void DrawWeapon_4() {

  PVector PXY = new PVector(Player_id.XY.x + width/2, Player_id.XY.y + height/2);
  // mode 0
  
  if (mousePressed) {
    Attack = true;
  }

  if (Attack && weapon4.cd <= 0) {
    weapon4.time++;
    weapon4.XY.x = PXY.x + weapon4.size*(cos(weapon4.angle + weapon4.time/10));
    weapon4.XY.y = PXY.y + weapon4.size*sin(weapon4.angle + weapon4.time/10);
    //mode3 加大啞鈴
    if (weapon_mode % 8 > 3){
      weapon4.size = 200;
    }else{
      weapon4.size = 150;
    }
    image(yaling, weapon4.XY.x, weapon4.XY.y,
    weapon4.size, weapon4.size);
    for (int i = Monster.size() - 1; i >= 0; i--) {
      Monster_id m = Monster.get(i);
      if (vector_length(weapon4.XY , m.XY) < weapon4.size && m.hit == false) {
        m.hit = true;
        m.HP -= Player_id.ATK;
        m.hitCD = 30;
        // mode 1 擊中後怪物擊退
        if (weapon_mode % 2 == 1 ) { 
        PVector knock = PVector.sub(m.XY, PXY);
        knock.normalize();
        knock.mult(100);     // 擊退距離
        m.XY.add(knock);
        }
        // mode4 給怪物上dot
        if (weapon_mode % 16 > 7) {            
          m.dotTimer = 60;                     // 持續 60 真
          m.dotDps   = Player_id.ATK / 120.0;   // 每針扣血
        }
      }
    }
    if (weapon4.time > 20) {
      Attack = false;
      weapon4.time = 0;
      weapon4.angle = vector_angle(new PVector(0, 0), new PVector(mouseX - width/2, mouseY - height/2)) - PI/3;
      weapon4.cd = 6;
    }
  }
  // mode 1
  if (weapon_mode % 2 == 1 && keyPressed && t % 30 == 0);

  // mode 2 空白鍵向前衝刺 造成傷害
  if (weapon_mode % 4 > 1 && key == ' ' && keyPressed && space_CD <= 0) {
    // 鼠標方向
    PVector dash = new PVector(mouseX - width/2, mouseY - height/2);
    dash.normalize();
    dash.mult(200); // 衝刺距離

    int tempHP = Player_id.HP;
    Player_id.XY.add(dash);
    
    for (int i = Monster.size() - 1; i >= 0; i--) {
      Monster_id m = Monster.get(i);
      PVector toMonster = PVector.sub(m.XY, PXY);
      float distanceToMonster = toMonster.mag();
      float angleToMonster = PVector.angleBetween(dash, toMonster);

      if (distanceToMonster < 250 && angleToMonster < PI/6) {      
        m.HP -= 100; // 衝刺攻擊    
      }
    }
    Player_id.HP = tempHP; // 恢復血量
    
    space_CD = 120; // 衝刺CD
  }
  if (weapon_mode % 4 > 1 && key == ' ' && keyPressed ) {
  }

  // mode 3
  if (weapon_mode % 8 > 3 && key == ' ' && keyPressed && space_CD <= 0) {
    for (int i = 0; i < 10; i++)
      Weapon_id.add(new Weapon_id(new PVector(PXY.x, PXY.y),
      random(0, 2 * PI), 15, 300));
    space_CD = 300;
  }
  
  // 更新怪物的被擊中冷卻，倒數至 0 後恢復可被擊中狀態
  for (int i = Monster.size() - 1; i >= 0; i--) {
    Monster_id m = Monster.get(i);
    if (m.hitCD > 0) {
      m.hitCD--;
    } else {
      m.hit = false;
    }
  }
  weapon4.cd -= 1;
  weapon4.mode4_cd --;
  
  // mode 5 站著時每秒回一滴血
  if (weapon_mode % 32 > 15 && t % 60 == 0) {
    Player_id.HP = min(Player_id.HP + 1, Player_id.MAX_HP);
  }

}
    

