void end(){
      //結束
  if (player.HP <= 0){
    background(0);
    fill(255, 0, 0);
    textAlign(CENTER);
    textSize(50);
    text("你沒畢業", width/2, height/2 - 100);
    textSize(30);
    text("獲得學分: " + credit, width/2, height/2);
    stage = 2;
  }
  if (credit >= 128){
    background(0);
    fill(255);
    textAlign(CENTER);
    textSize(50);
    text("恭喜你畢業了", width/2, height/2 - 100);
    textSize(30);
    text("獲得學分: " + credit, width/2, height/2);
    stage = 2;
  }
}