class Player{
  PVector pos, vel;  int HP, ATK;

  Player(PVector pos, PVector vel, int HP, int ATK){
    this.pos = pos; this.vel = vel;
    this.HP  = HP;  this.ATK = ATK;
  }

  void update(){ pos.add(vel); }

  PVector worldPos(){ return new PVector(pos.x + width/2, pos.y + height/2); }

  void display(){
    image((vel.x<0||face==1)?playerL:playerR, width/2, height/2, 100, 100);
    textSize(20); textAlign(CENTER);
    text("HP: "+HP, width/2, height/2+70);
    text("XY: "+int(pos.x)+", "+int(pos.y), width/2, height/2+90);
  }

  /* ---------- 控制 ---------- */
  void onKeyPress(char k,int vmax){
    if(k=='w'&&vel.y>-vmax) vel.y-=vmax;
    if(k=='a'&&vel.x>-vmax){ vel.x-=vmax; face=1; }
    if(k=='s'&&vel.y< vmax) vel.y+=vmax;
    if(k=='d'&&vel.x< vmax){ vel.x+=vmax; face=0; }
  }
  void onKeyRelease(char k,int vmax){
    if(k=='w'&&vel.y< vmax) vel.y+=vmax;
    if(k=='a'&&vel.x< vmax) vel.x+=vmax;
    if(k=='s'&&vel.y>-vmax) vel.y-=vmax;
    if(k=='d'&&vel.x>-vmax) vel.x-=vmax;
  }
}