class Weapon{
  PVector pos; float angle,speed,life;

  Weapon(PVector pos,float angle,float speed,float life){
    this.pos=pos; this.angle=angle; this.speed=speed; this.life=life;
  }

  boolean update(){
    pos.x += cos(angle)*speed;
    pos.y += sin(angle)*speed;
    return --life<=0;
  }
  void display(){ image(book,pos.x,pos.y,100,100); }
}