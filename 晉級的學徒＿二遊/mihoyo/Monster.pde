class Monster_id {
  PVector XY;
  float   HP, ATK, speed;
  int     time;
  String  name;
  
  int   dotTimer = 0;   // 剩餘 DOT 時間（frame）
  float dotDps   = 0;   // 每 frame 扣血量
  
  Monster_id(PVector XY, float HP, float ATK, float speed, int time, String name) {
    this.XY = XY; this.HP = HP; this.ATK = ATK; this.speed = speed;
    this.time = time; this.name = name;
    // 初始化 DOT
    this.dotTimer = 0;
    this.dotDps   = 0;
  }
  
  void monster(PVector m, String name) {
    stroke(153); rect(m.x, m.y, 80, 80);
    textAlign(CENTER); textSize(40); fill(0); text(name, m.x, m.y);
    textSize(20); fill(255); text("HP: " + HP, m.x, m.y + 60);
  }
}

ArrayList<Monster_id> Monster   = new ArrayList<Monster_id>();

void DrawMonster() {
  float PX = Player_id.XY.x + width/2;
  float PY = Player_id.XY.y + height/2;
  PVector PXY = new PVector(PX, PY);

  for (int i = 0; i < Monster.size(); i++) {
    Monster_id m = Monster.get(i);
    // ── weapon4_DOT  ──
    if (m.dotTimer > 0) {
      m.HP -= m.dotDps;
      m.dotTimer--;
    }
    m.time -= 1;
    m.XY.x -= cos(vector_angle(PXY, m.XY)) * m.speed;
    m.XY.y -= sin(vector_angle(PXY, m.XY)) * m.speed;
    m.monster(m.XY, m.name);
    if (vector_length(PXY, m.XY) < 50) {
      Player_id.HP -= 1;
      m.HP -= 100;
      credit -= 1;
    }
    if (m.HP <= 0){ Monster.remove(i); credit += 1; }
  }
}