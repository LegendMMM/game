/*  向量工具  */
float vector_length(PVector a,PVector b){ return dist(a.x,a.y,b.x,b.y); }
float vector_angle (PVector a,PVector b){ return atan2(b.y-a.y,b.x-a.x); }
float angleFrom    (PVector a,PVector b){ return vector_angle(a,b); }

/*  武器 & 怪物更新  */
void updateWeapons(){
  mode3_CD--;
  /* 依武器模式自動射擊（Mode 1 2 3） */
  PVector pWorld = player.worldPos();

  // Mode 1：方向鍵連射
  if((weapon_mode&1)==1 && keyPressed && frameCount%30==0){
    weapons.add(new Weapon(pWorld, vector_angle(new PVector(0,0), player.vel), 15, 300));
  }

  // Mode 2：定時自動鎖敵
  if((weapon_mode&2)==2 && frameCount%30==0 && monsters.size()>0){
    Monster m = monsters.get(int(random(monsters.size())));
    weapons.add(new Weapon(pWorld, vector_angle(pWorld, m.pos), 15, 300));
  }

  // Mode 3：空白鍵散射
  if((weapon_mode&4)==4 && key==' '&&keyPressed && mode3_CD<=0){
    for(int i=0;i<10;i++){
      float ang = vector_angle(new PVector(width/2,height/2),
                               new PVector(mouseX,mouseY)) + random(-0.5,0.5);
      weapons.add(new Weapon(pWorld, ang, 15, 300));
    }
    mode3_CD = 300;
  }

  /* 更新顯示 & 判定 */
  for(int i=weapons.size()-1;i>=0;--i){
    Weapon w = weapons.get(i);
    w.display();
    if(w.update()){ weapons.remove(i); continue; }

    /* 與怪物碰撞 */
    for(int j=monsters.size()-1;j>=0;--j){
      Monster m = monsters.get(j);
      if(vector_length(w.pos, m.pos) < 140 && m.freeze<=0){
        m.HP -= player.ATK;

        // Mode 5：冰凍/貫穿
        if((weapon_mode&16)==16) m.freeze = 17;
        else if((weapon_mode&8)==0) { weapons.remove(i); }

        if(m.HP<=0){ monsters.remove(j); credit++; }
        break;
      }
    }

    /* Mode 4：停留地刺 */
    if(w.life<=0 && (weapon_mode&8)==8 && w.speed!=0){
      w.speed = 0; w.life = 300;
    }
  }
}

void updateMonsters(){
  PVector pWorld = player.worldPos();

  for(int i=monsters.size()-1;i>=0;--i){
    Monster m = monsters.get(i);
    m.update(pWorld); m.display();

    if(vector_length(pWorld,m.pos) < 50){
      player.HP--; m.HP -= 100;
      if(m.HP<=0) monsters.remove(i);
    }
  }

  /* HP 歸零則進 End 場景 */
  if(player.HP<=0) stage = 2;
  if(credit >= 128) stage = 2;
}