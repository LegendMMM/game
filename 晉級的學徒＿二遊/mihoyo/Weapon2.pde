/////////////--------------音------------------------//////////////////
//mode0 每６０幀畫面隨機一個位置出現音符 在指定的拍數內點擊音符即對範圍造成傷害 done
//mode1 獲得連擊模式 如果連續攻擊的話會有額外的傷害 
//mode2 節奏變快    not done
//mode3 空白鍵按下後，怪物會往音符拉近  done
//mode4 操作者無需按到指定位置即可造成傷害  done
//mode5 造成的傷害不再根據完美時間而減少
PVector weaponXY = new PVector(0, 0);

class Weapon_id_2 {
    float time; float cd; float damage;
    int tick;
    int combo;
    PVector XY;

    boolean attack = false;
    boolean draw = false;
    Weapon_id_2() {
        this.time = 0; this.cd = 0;
        this.XY = new PVector(0, 0);
        this.attack = false;
        this.tick = 60;
        this.draw = false;
        this.damage = 20;
        this.combo = 0;

    }
}
Weapon_id_2 weapon2 = new Weapon_id_2();
void DrawWeapon_2() {
    weapon2.time++;
    PVector PXY = new PVector(Player_id.XY.x + width/2, Player_id.XY.y + height/2);
    // mode 0
    if (weapon_mode % 4 > 1) {       //mode 2
        weapon2.tick = 40;
    }
    if (weapon2.time % weapon2.tick == 0) {
        weapon2.XY.x = PXY.x + random(-width/3, width/3);
        weapon2.XY.y = PXY.y + random(-height/3, height/3);
        weapon2.time = 0;
        if (weapon2.attack == false) {
            weapon2.combo = 0;
        }
        weapon2.attack = false;
    }

    image(music, weapon2.XY.x, weapon2.XY.y, 100, 100);
    if (weapon2.attack == false) {
        noFill();
        stroke(255, 255, 0);
        circle(weapon2.XY.x, weapon2.XY.y, 100);
        fill(255);
    }
    // 播放節拍音效：標準節奏於第 40 幀（tick = 60），加速節奏於第 30 幀（tick = 40）
    int playFrame = (weapon2.tick == 60) ? 40 : 30;
    if (weapon2.time == playFrame){
        touch.rewind();   // 從頭播放
        touch.play();
    }
    if (mousePressed  && weapon2.attack == false) {
        if (vector_length(new PVector(PXY.x + mouseX - width/2, PXY.y + mouseY - height/2), weapon2.XY) < 50 
        || weapon_mode % 16 > 7) {      //mode 4
            weaponXY = new PVector(weapon2.XY.x, weapon2.XY.y);
            weapon2.attack = true;
            float damage = 0;
            // mode 5
            if (weapon_mode % 32 > 15) {
                damage = weapon2.damage;
            
            }else if (weapon_mode % 4 > 1) {
                damage = weapon2.damage - abs(30 - (weapon2.time));   //mode 2
            }
            else {
                damage = weapon2.damage - abs(40 - (weapon2.time));   //mode 0
            }
            if (damage <= 0) {
                damage = 0;
                weapon2.combo = 0;
            }
            if (weapon_mode % 2 == 1) { 
                damage += weapon2.combo;   //mode 1
                weapon2.combo += 1;
            }
            

            for (int i = Monster.size() - 1; i >= 0; i--) {
                Monster_id m = Monster.get(i);
                if (vector_length(weapon2.XY , m.XY) < 1000) {
                    m.HP -= damage;
                    if (m.HP <= 0){ Monster.remove(i); credit += 1; }
                }
            } 
            weapon2.draw = true;      
        }
    }
    
    if (weapon_mode % 8 > 3 ) {    // mode 3
        // 如果空白鍵被按下且冷卻結束，啟動拉近效果並設定冷卻時間
        if (key == ' ' && keyPressed && space_CD == 0) {
            space_CD = 120;   
        }

        // 冷卻期間內持續執行拉近效果
        if (space_CD > 90) {
            for (int i = Monster.size() - 1; i >= 0; i--) {
                Monster_id m = Monster.get(i);
                if (vector_length(weapon2.XY , m.XY) < 1000) {
                    m.XY.x -= cos(vector_angle(weapon2.XY, m.XY)) * 10;
                    m.XY.y -= sin(vector_angle(weapon2.XY, m.XY)) * 10;
                }
            }
        }
    }
    if (weapon2.draw){
        noFill();
        stroke(255, 255, 0);
        circle(weaponXY.x, weaponXY.y, 100 + temp*100 );
        fill(255);
        temp++;
        if (temp > 20) {
            temp = 0;
            weapon2.draw = false;
        }
    }

  
   if (weapon_mode % 2 == 1){
     // 在模式1時印出combo值
      textAlign(CENTER);
      textSize(32);
      fill(255, 255, 0);
      text("Combo: " + weapon2.combo, weaponXY.x, weaponXY.y - 50);
      fill(255);
   }

//   if (weapon_mode % 4 >s 1)

//   if (weapon_mode % 8 > 3)

//   if (weapon_mode % 16 > 7)
  
//   if (weapon_mode % 32 > 15)
  
    if (space_CD > 0) space_CD--;
}
