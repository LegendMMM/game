PImage book, timer, computer, pen, music, yaling;
void setup(){
  size(800, 800);
  rectMode(CENTER);
  imageMode(CENTER);
  book = loadImage("pic/book.PNG");
  timer = loadImage("pic/timer.PNG");
  computer = loadImage("pic/computer.PNG");
  pen = loadImage("pic/pen.PNG");
  music = loadImage("pic/music.PNG");
  yaling = loadImage("pic/yaling.PNG");
}

//變數
int t = 0, T = 0, v = 10, credit = 0, stage = 0;
Player_id Player_id = new Player_id(new PVector(0, 0), new PVector(0, 0), 100, 10);
ArrayList<Weapon_id> Weapon_id = new ArrayList<Weapon_id>();
ArrayList<Monster_id> Monster = new ArrayList<Monster_id>();

//主程式
void draw(){

  //早上
  if (stage == 0){
    morning();
  }
  //商店
  if (stage == 1){
    background(100);
    shop();
  }

  //學分
  textAlign(LEFT);
  textSize(35);
  text("學分 " + credit, 50, 50);

  //計時器
  RunTimer();
}


//怪物
class Monster_id{
  PVector XY;
  float HP, ATK, speed;
  Monster_id(PVector XY, float HP, float ATK, float speed){
    this.XY = XY;
    this.HP = HP;
    this.ATK = ATK;
    this.speed = speed;
  }
  void monster(PVector m, String name){
    stroke(153);
    rect(m.x, m.y, 80, 80);
    textAlign(CENTER);
    textSize(40);
    fill(0);
    text(name, m.x, m.y);
    textSize(20);
    fill(255);
    text("HP: " + HP, m.x, m.y + 60);
  }
}
//角色
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
//武器
class Weapon_id{
  PVector XY;
  float angle;
  float speed;
  float time;
  Weapon_id(PVector XY, float angle, float speed, float time){
    this.XY = XY;
    this.angle = angle;
    this.speed = speed;
    this.time = time;
  }
}


void morning(){
  background(200);
  if (credit >= 50){
    stage = 1;
    Weapon_id = new ArrayList<Weapon_id>();
    Monster =  new ArrayList<Monster_id>();
  }
  pushMatrix();
  


  //轉換座標系
  translate(-Player_id.XY.x, -Player_id.XY.y);

  //移動
  Player_id.XY.add(Player_id.speed);
  
  
  //windowMove(int(Player_id.XY.x), int(Player_id.XY.y));
  

  //武器
  DrawWeapon();
  
  //生怪
  DrawMonster();

  if (keyPressed) {
    if (key == 'm') {
      Monster.add(new Monster_id(new PVector(random(0, width), random(0, height)), int(random(10, 100)), 10, random(1, 10)));
    }
  }
  popMatrix();
  //主要角色
  DrawPlayer();
}

//畫角色
void DrawPlayer(){
  noStroke(); 
  fill(255, 100);
  circle(width/2 - Player_id.speed.x, height/2 - Player_id.speed.y, 100);
  fill(255, 255);
  circle(width/2, height/2, 100);
  textSize(20);
  textAlign(CENTER);
  text("HP: " + Player_id.HP, width/2, height/2 + 70);
  text("XY: " + int(Player_id.XY.x) + ", " + int(Player_id.XY.y), width/2, height/2 + 90);
}
//計時器
void RunTimer(){
  t += 1;
  if(t > 60){
    T += 1;
    t = 0;
  }
  image(timer, width/2 - 25, 25, 50, 50);
  textAlign(LEFT);
  textSize(50);
  text(T, width/2, 50);
}
//畫武器
void DrawWeapon(){
  for (int i = Weapon_id.size() - 1; i >= 0; i--){
    Weapon_id.get(i).XY.x += cos(Weapon_id.get(i).angle) * Weapon_id.get(i).speed;
    Weapon_id.get(i).XY.y += sin(Weapon_id.get(i).angle) * Weapon_id.get(i).speed;
    Weapon_id.get(i).time -= 1;
    image(book, Weapon_id.get(i).XY.x, Weapon_id.get(i).XY.y, 100, 100);
    boolean weaponRemoved = false;
    for (int j = Monster.size() - 1; j >= 0; j--){
      if (vector_length(Weapon_id.get(i).XY, Monster.get(j).XY) < 140){
        Monster.get(j).HP -= Player_id.ATK;
        println("hit!");
        if (Monster.get(j).HP <= 0){
          println("dead!");
          Monster.remove(j);
          credit += 1;
        }
        Weapon_id.remove(i);
        weaponRemoved = true;
        break;
      }
    }
    if (weaponRemoved){
      break;
    }
    if (Weapon_id.get(i).time <= 0){
      Weapon_id.remove(i);
    }
  }
}
//畫怪物
void DrawMonster(){
  float PX = Player_id.XY.x + width/2;
  float PY = Player_id.XY.y + height/2;
  PVector PXY = new PVector(PX, PY);
  for (int i = 0; i < Monster.size(); i = i + 1){
    Monster.get(i).XY.x -= cos(vector_angle(PXY, Monster.get(i).XY)) * Monster.get(i).speed;
    Monster.get(i).XY.y -= sin(vector_angle(PXY, Monster.get(i).XY)) * Monster.get(i).speed;
    Monster.get(i).monster(Monster.get(i).XY, str(i)); 
    if (vector_length(PXY, Monster.get(i).XY) < 50){
      Player_id.HP -= 1;
      println("hit!");
      Monster.get(i).HP -= 100;
      if (Monster.get(i).HP <= 0){
        println("dead!");
        Monster.remove(i);
      }
    }
  }
}


//攻擊
void mousePressed() {
  Weapon_id.add(new Weapon_id(new PVector (Player_id.XY.x + width/2, Player_id.XY.y + height/2), vector_angle(new PVector (0, 0),new PVector (mouseX - width/2, mouseY - height/2)), 10, 300));
}
//移動
void keyPressed(){
    if (key == 'w' && Player_id.speed.y > -v) {
      Player_id.speed.y -= v;
    }
    if (key == 'a' && Player_id.speed.x > -v) {
      Player_id.speed.x -= v;
    }
    if (key == 's' && Player_id.speed.y < v) {
      Player_id.speed.y += v;
    }
    if (key == 'd' && Player_id.speed.x < v) {
      Player_id.speed.x += v;
    }
}
void keyReleased() {
    if (key == 'w' && Player_id.speed.y < v) {
      Player_id.speed.y += v;
    }
    if (key == 'a' && Player_id.speed.x < v) {
      Player_id.speed.x += v;
    }
    if (key == 's' && Player_id.speed.y > -v) {
      Player_id.speed.y -= v;
    }
    if (key == 'd' && Player_id.speed.x > -v) {
      Player_id.speed.x -= v;
    }
}

//商店
void shop(){
  image(computer, width/2, height/2 + 200, width - 100, 100);
  image(pen, width/2, height/2 + 100, width - 100, 100);
  image(music, width/2, height/2, width - 100, 100);
  image(book, width/2, height/2 - 100, width - 100, 100);
  image(yaling, width/2, height/2 - 200, width - 100, 100);
  if (mouseX > width/2 - 200 && mouseX < width/2 + 200 && mouseY > height/2 - 200 && mouseY < height/2 + 200){
    if (mousePressed){
      stage = 0;
      credit -= 50;
    }
  }
}


//向量運算
float vector_length(PVector v1, PVector v2){
  float length = dist(v1.x, v1.y, v2.x, v2.y);
  return length;
}
float vector_angle(PVector v1,PVector v2){
  float angle = atan2(v2.y - v1.y, v2.x - v1.x);
  return angle;
}
