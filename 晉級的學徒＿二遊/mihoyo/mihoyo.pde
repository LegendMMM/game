
void setup(){
  size(800, 800);
  rectMode(CENTER);
}

//生成怪物
class Monster_id{
  PVector XY;
  int HP, ATK;
  Monster_id(PVector XY, int HP, int ATK){
    this.XY = XY;
    this.HP = HP;
    this.ATK = ATK;
  }
  void monster(PVector m){
    stroke(153);
    rect(m.x, m.y, 80, 80);
  }
}
ArrayList<Monster_id> Monster = new ArrayList<Monster_id>();

class Player_id{
  PVector XY, speed;
  int HP, ATK;
  Player_id(PVector XY, PVector speed, int HP, int ATK){
    this.XY = XY;
    this.speed = speed;
    this.HP = HP;
    this.ATK = ATK;
  }
}



//攻擊
void mouseClicked() {
  
}

//變數
int t = 0, T = 0, v = 10;
Player_id Player_id = new Player_id(new PVector(0, 0), new PVector(0, 0), 100, 10);

//主程式
void draw(){
  background(100);
  noStroke();
  
  //主要角色
  pushMatrix();
  fill(255, 100);
  circle(width/2 - Player_id.speed.x, height/2 - Player_id.speed.y, 100);
  fill(255, 255);
  circle(width/2, height/2, 100);
  println(Player_id.HP);

  //移動
  translate(-Player_id.XY.x, -Player_id.XY.y);
  Player_id.XY.add(Player_id.speed);
  
  //windowMove(Player_id.XY.x, Player_id.XY.y);
  
  //計時器
  t += 1;
  if(t > 60){
    T += 1;
    t = 0;
  }
  text(T,50,100);
  textSize(100);
  
  //生怪
  for (int i = 0; i < Monster.size(); i = i + 1){
    float PX = Player_id.XY.x + width/2;
    float PY = Player_id.XY.y + height/2;
    PVector PXY = new PVector(PX, PY);
    Monster.get(i).XY.x -= cos(vector_angle(PXY, Monster.get(i).XY)) * 5;
    Monster.get(i).XY.y -= sin(vector_angle(PXY, Monster.get(i).XY)) * 5;
    Monster.get(i).monster(Monster.get(i).XY); 
    if (vector_length(PXY, Monster.get(i).XY) < 50){
      Player_id.HP -= 1;
      println("hit!");
      Monster.get(i).HP -= 100;
      Monster.remove(i);
    }
  }

  if (keyPressed) {
    if (key == 'm') {
      Monster.add(new Monster_id(new PVector(random(0, width), random(0, height)), 100, 10));
    }
  }

  popMatrix();

}

void keyPressed(){
    if (key == 'w' && Player_id.speed.y > -10) {
      Player_id.speed.y -= v;
    }
    if (key == 'a' && Player_id.speed.x > -10) {
      Player_id.speed.x -= v;
    }
    if (key == 's' && Player_id.speed.y < 10) {
      Player_id.speed.y += v;
    }
    if (key == 'd' && Player_id.speed.x < 10) {
      Player_id.speed.x += v;
    }
}

void keyReleased() {
    if (key == 'w' && Player_id.speed.y < 10) {
      Player_id.speed.y += v;
    }
    if (key == 'a' && Player_id.speed.x < 10) {
      Player_id.speed.x += v;
    }
    if (key == 's' && Player_id.speed.y > -10) {
      Player_id.speed.y -= v;
    }
    if (key == 'd' && Player_id.speed.x > -10) {
      Player_id.speed.x -= v;
    }
}




float vector_length(PVector v1, PVector v2){
  float length = dist(v1.x, v1.y, v2.x, v2.y);
  return length;
}

float vector_angle(PVector v1,PVector v2){
  float angle = atan2(v2.y - v1.y, v2.x - v1.x);
  return angle;
}
