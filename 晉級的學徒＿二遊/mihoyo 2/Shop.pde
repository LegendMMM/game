/*  商店場景  */
void shop(){
  background(100); temp++;

  rectMode(CENTER); fill(255); stroke(0);
  for(int k=-2;k<=2;k++){
    rect(width/2, height/2 + k*100, width-100, 100);
  }

  textAlign(CENTER); textSize(20); fill(0);

  /* 1~5 行說明 + 已解鎖標示 */
  String[] info = {
    "每按方向鍵射出書本",
    "定時自動鎖敵射擊",
    "Space 朝周圍散射書本",
    "書本停留造成持續傷害",
    "書本貫穿目標"
  };
  for(int i=0;i<5;i++){
    int y = height/2 + 200 - i*100;
    text(info[i], width/2, y);
    if ((weapon_mode >> i & 1) == 1){
      fill(100,0,0); text("已解鎖", width/2, y-25); fill(0);
    }
  }

  /* 滑鼠點擊購買 */
  if (mousePressed && temp >= 60){
    for(int i=0;i<5;i++){
      int yTop = height/2 + 150 - i*100;
      if ((weapon_mode >> i & 1) == 0 &&
          mouseX>50 && mouseX<width-50 &&
          mouseY>yTop && mouseY<yTop+100){
        weapon_mode |= 1<<i;
        credit -= 50; level++; temp = 0; stage = 0;
      }
    }
  }
}