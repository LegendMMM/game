/*  標題場景  */
void title(){
  background(0); fill(255); textAlign(CENTER);

  textSize(50); text("遊戲介紹", width/2, height/2 - 100);
  textSize(30);
  text("使用 WASD 移動，滑鼠射擊。", width/2, height/2);
  text("50 學分進商店，死亡或 128 學分結束。", width/2, height/2 + 50);
  text("按 Space 開始", width/2, height/2 + 150);

  if (key == ' ') stage = 0;
}