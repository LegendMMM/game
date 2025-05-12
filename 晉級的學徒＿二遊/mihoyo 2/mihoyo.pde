/*  主流程：setup / draw / 事件  */

void setup(){
  minim = new Minim(this);
  bgm   = minim.loadFile("data/音樂.mp3");
  bgm.loop();

  TCFont = createFont("NotoSansTC-Black.otf", 28);
  textFont(TCFont);

  size(800, 800);
  rectMode(CENTER);
  imageMode(CENTER);

  book  = loadImage("pic/book.PNG");
  timer = loadImage("pic/timer.PNG");
  computer = loadImage("pic/computer.PNG");
  pen      = loadImage("pic/pen.PNG");
  music    = loadImage("pic/music.PNG");
  yaling   = loadImage("pic/yaling.PNG");

  backgroundImg = loadImage("pic/background.PNG");
  playerL = loadImage("pic/playerL.PNG");
  playerR = loadImage("pic/playerR.PNG");
}

void draw(){
  if      (stage == -1)  title();
  else if (stage ==  0)  battle();
  else if (stage ==  1)  shop();
  else if (stage ==  2)  end();

  drawHUD();
}

/* ---------- 事件 ---------- */
void mousePressed(){
  weapons.add(new Weapon(player.worldPos(),angleFrom(new PVector(0,0),new PVector(mouseX - width/2, mouseY - height/2)),15, 300));
}

void keyPressed(){  player.onKeyPress(key, v); }
void keyReleased(){ player.onKeyRelease(key, v); }

/* ---------- HUD (計分＋計時) ---------- */
void drawHUD(){
  textAlign(LEFT); textSize(35);
  text("學分 " + credit, 50, 50);

  if (++t > 59){ T++; t = 0; }
  image(timer, width/2 - 25, 25, 50, 50);
  textAlign(LEFT); textSize(50);
  text(T, width/2, 50);
}

void stop(){
  bgm.close();
  minim.stop();
  super.stop();
}