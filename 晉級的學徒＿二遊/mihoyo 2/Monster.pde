class Monster{
  PVector pos; float HP, ATK, speed; int freeze; String name;

  Monster(PVector pos,float HP,float ATK,float speed,int freeze,String name){
    this.pos=pos; this.HP=HP; this.ATK=ATK;
    this.speed=speed; this.freeze=freeze; this.name=name;
  }

  void update(PVector target){
    if(freeze-->0) return;
    float ang = angleFrom(target,pos);
    pos.x -= cos(ang)*speed; pos.y -= sin(ang)*speed;
  }

  void display(){
    stroke(153); rect(pos.x,pos.y,80,80);
    textAlign(CENTER);
    textSize(40); fill(0); text(name,pos.x,pos.y);
    textSize(20); fill(255); text("HP: "+HP,pos.x,pos.y+60);
  }
}