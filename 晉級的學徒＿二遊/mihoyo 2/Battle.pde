/*  主要戰鬥場景  */
void battle(){
  background(200);

  /* 進商店條件 */
  if (credit >= 50 && weapon_mode != 31) stage = 1;

  /* 無限地圖背景平鋪 */
  imageMode(CENTER);
  for(int i=0;i<4;i++){
    for(int j=0;j<4;j++){
      image(backgroundImg,
            width  * (i-1.5f) + (-player.pos.x % width),
            height * (j-1.5f) + (-player.pos.y % height),
            width, height);
    }
  }

  pushMatrix();
  translate(-player.pos.x, -player.pos.y);

  /* 更新 & 繪製 */
  player.update();
  updateWeapons();
  updateMonsters();

  /* 每 10 幀隨機生怪 */
  if (frameCount % 10 == 0){
    float ang = random(TWO_PI);
    String name = new String[]{"中", "英", "文"}[int(random(3))];
    monsters.add(new Monster(
      new PVector(player.pos.x + cos(ang)*random(width, width*2),
                  player.pos.y + sin(ang)*random(height, height*2)),
      int(random(10,100)), 10, random(1,7.5f), 0, name));
  }
  popMatrix();

  /* 角色顯示與等級提示 */
  player.display();
  textSize(32); textAlign(CENTER);
  text("Lv " + level, width - 80, 40);
}