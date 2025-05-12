void open() {
    background(0);
    fill(255);
    textAlign(CENTER);
    textSize(50); 
    text("遊戲介紹", width/2, height/2 - 100);
    
    textSize(30);
    text("遊玩方式", width/2, height/2);
    text("使用wasd進行上下左右移動，並且玩家會保持在畫面中心。", width/2, height/2 + 50);
    text("你可以使用滑鼠來射擊", width/2, height/2 + 100);
    text("獲得足夠的分數(50分)時，會進入到商店畫面。", width/2, height/2 + 150);
    text("死亡或是學分夠了，即結束遊戲。", width/2, height/2 + 200);
    text("按下空白鍵開始遊戲", width/2, height/2 + 300);
    
    if (key == ' ') stage = 0;
}

void morning() {
    background(200);
    if (credit >= 50 && weapon_mode != 31) stage = 1;

    imageMode(CENTER);
    for (int i = 0; i < 4; i++)
        for (int j = 0; j < 4; j++)
            image(backgroundImg, 
                        width * (i - 1.5) + (-Player_id.XY.x % width),
                        height * (j - 1.5) + (-Player_id.XY.y % height),
                        width, height);

    pushMatrix();
    translate(-Player_id.XY.x, -Player_id.XY.y);

    Player_id.XY.add(Player_id.speed);
    DrawWeapon();
    DrawMonster();

    if (t % 10 == 0) {
        float randomangle = random(0, 2 * PI);
        int randomname = int(random(0, 2));
        String m_name = randomname == 0 ? "中" : randomname == 1 ? "英" : "文";
        Monster.add(new Monster_id(
            new PVector(Player_id.XY.x + cos(randomangle) * random(width, width*2),
                                 Player_id.XY.y + sin(randomangle) * random(height, height*2)),
            int(random(10, 100)), 10, random(1, 7.5), 0, m_name));
    }
    popMatrix();

    DrawPlayer();
    text(level, 400, 300);
}

void shop() {
    rectMode(CENTER); 
    fill(255); 
    stroke(0);
    for (int i = -2; i <= 2; i++)
        rect(width/2, height/2 + i*100, width - 100, 100);

    textAlign(CENTER); 
    textSize(20); 
    fill(0);
    
    text("每按下方向鍵，朝該方向射出一本書本", width/2, height/2 + 200);
    if (weapon_mode % 2 == 1) { 
        fill(100, 0, 0); 
        text("已解鎖", width/2, height/2 + 175); 
        fill(0); 
    }

    text("每過一段時間隨機鎖定一個敵人射擊", width/2, height/2 + 100);
    if (weapon_mode % 4 > 1) { 
        fill(100, 0, 0); 
        text("已解鎖", width/2, height/2 + 75); 
        fill(0); 
    }

    text("按下空白鍵，朝四面八方散射書本", width/2, height/2);
    if (weapon_mode % 8 > 3) { 
        fill(100, 0, 0); 
        text("已解鎖", width/2, height/2 - 25); 
        fill(0); 
    }

    text("射出去的書本不會立即消失，將會停留在原地造成持續傷害，持續一段時間",
            width/2, height/2 - 100);
    if (weapon_mode % 16 > 7) { 
        fill(100, 0, 0); 
        text("已解鎖", width/2, height/2 - 125); 
        fill(0); 
    }

    text("書本觸碰到敵人後將不會消失，改為貫穿傷害", width/2, height/2 - 200);
    if (weapon_mode % 32 > 15) { 
        fill(100, 0, 0); 
        text("已解鎖", width/2, height/2 - 225); 
        fill(0); 
    }

    if (mousePressed && temp >= 60) {
        if (weapon_mode % 2 == 0   && mouseY > height/2 + 150 && mouseY < height/2 + 250) unlock(1);
        if (weapon_mode % 4 <= 1   && mouseY > height/2 +  50 && mouseY < height/2 + 150) unlock(2);
        if (weapon_mode % 8 <= 3   && mouseY > height/2 -  50 && mouseY < height/2 +  50) unlock(4);
        if (weapon_mode % 16 <= 7  && mouseY > height/2 - 150 && mouseY < height/2 -  50) unlock(8);
        if (weapon_mode % 32 <= 15 && mouseY > height/2 - 250 && mouseY < height/2 - 150) unlock(16);
    }
}

void unlock(int value) {
    weapon_mode += value;
    stage = 0;
    credit -= 50;
    level += 1;
    temp = 0;
}