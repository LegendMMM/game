void open() {
    background(0);
    fill(255);
    textAlign(CENTER);
    textSize(50); 
    text("遊戲介紹", width/2, height/2 - 100);
    
    textSize(30);
    text("遊玩方式", width/2, height/2);
    text("使用wasd進行上下左右移動，並且玩家會保持在畫面中心。", width/2, height/2 + 50);
    text("你可以使用滑鼠來攻擊", width/2, height/2 + 100);
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
    switch (career) {
        case 0: DrawWeapon(); break;
        case 1: DrawWeapon_1(); break;
        case 2: DrawWeapon_2(); break;
        case 3: DrawWeapon_3(); break;
        case 4: DrawWeapon_4(); break;
    }
    DrawMonster();

    if (t % 10 == 0) {
        float randomangle = random(0, 2 * PI);
        int randomname = int(random(0, 3));
        String m_name = "";
        switch (career) {
            case 0: m_name = new String[]{"文", "英", "國"}[randomname]; break;
            case 1: m_name = new String[]{"微", "積", "分"}[randomname]; break;
            case 2: m_name = new String[]{"", "", ""}[randomname]; break;
            case 3: m_name = new String[]{"術", "美", "藝"}[randomname]; break;
            case 4: m_name = new String[]{"體", "球", "動"}[randomname]; break;
        }
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
    String[] ability = {"", "", "", "", ""};
    switch (career) {
        case 0: ability = new String[]{"每按下方向鍵，朝該方向射出一本書本", 
                            "每過一段時間隨機鎖定一個敵人射擊", 
                            "按下空白鍵，朝四面八方散射書本", 
                            "射出去的書本不會立即消失，將會停留在原地造成持續傷害，持續一段時間", 
                            "書本觸碰到敵人後將不會消失，改為貫穿傷害"}; break;
        case 1: ability = new String[]{"路徑上造成數字一半的傷害", 
                            "0 變為一擊必殺", 
                            "增加怪物當前血量的50%作為傷害", 
                            "空白鍵將所有數字改為 9 (CD:1)", 
                            "每次點擊多一次隨機攻擊"}; break;
        case 2: ability = new String[]{"", 
                            "", 
                            "", 
                            "", 
                            ""}; break;
        case 3: ability = new String[]{"空白鍵施放時間暫停", 
                            "敵人碰到水彩時會緩速", 
                            "水彩範圍增加", 
                            "水彩持續效果增加", 
                            "水彩有拉回效果"}; break;
        case 4: ability = new String[]{"攻擊擊退", 
                            "空白鍵向前衝刺 消滅路進上敵人", 
                            "加大啞鈴", 
                            "攻擊時給怪物上dot狀態", 
                            "站著時每秒回一滴血"}; break;
    }
    
    for (int i = 0; i < 5; i++) {
        fill(0);
        text(ability[i], width/2, height/2 + 200 - i*100);
        if (weapon_mode % (int(pow(2, i + 1))) > (int(pow(2, i)) - 1)) {
            fill(100, 0, 0); 
            text("已解鎖", width/2, height/2 + 200 - i*100 + 25); 
            fill(0);
        }
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