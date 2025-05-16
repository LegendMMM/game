import ddf.minim.*;                                  //★

// ─── 全域資源 ───
PImage book, timer, computer, pen, music, yaling, backgroundImg, playerL, playerR;
PFont  TCFont;
Minim  minim;
AudioPlayer bgm;

// ─── 全域狀態 ───
int career = 2;              // 職業        文理音藝體 0 1 2 3 4
int t = 0, T = 0;            // 計時
int v = 10;                  // 速度上限
int credit = 40;              // 學分
int stage = -1;              // -1:開場 0:白天 1:商店 2:結束
int level = 1;               // 商店購買次數
int weapon_mode = 0;         // 武器位元狀態
int space_CD = 0;            // space冷卻
int face = 0;                // 0:右 1:左
int temp = 0;                // 商店防誤觸計時
float weapon_4_mode0_time = 0;   // 啞鈴攻擊冷卻
boolean Attack = false;      // 攻擊狀態



// ─── Start ───
void setup() {
    minim = new Minim(this);
    bgm   = minim.loadFile("data/音樂.mp3");
    //bgm.loop();

    TCFont = createFont("NotoSansTC-Black.otf", 28);
    textFont(TCFont);

    size(800, 800);
    rectMode(CENTER);
    imageMode(CENTER);

    book          = loadImage("pic/book.PNG");
    timer         = loadImage("pic/timer.PNG");
    computer      = loadImage("pic/computer.PNG");
    pen           = loadImage("pic/pen.PNG");
    music         = loadImage("pic/music.PNG");
    yaling        = loadImage("pic/yaling.PNG");
    backgroundImg = loadImage("pic/background.jpg");
    playerL       = loadImage("pic/playerL.PNG");
    playerR       = loadImage("pic/playerR.PNG");
}

void draw() {
    if (stage == -1) open();
    if (stage ==  0) morning();
    if (stage ==  1) { temp += 1; background(100); shop(); }

    // ── 結束判定 ──
    if (Player_id.HP <= 0) {
        background(0);
        fill(255, 0, 0);
        textAlign(CENTER);
        textSize(50); text("你沒畢業", width/2, height/2 - 100);
        textSize(30); text("獲得學分: " + credit, width/2, height/2);
        stage = 2;
    }
    if (credit >= 128) {
        background(0);
        fill(255);
        textAlign(CENTER);
        textSize(50); text("恭喜你畢業了", width/2, height/2 - 100);
        textSize(30); text("獲得學分: " + credit, width/2, height/2);
        stage = 2;
    }

    // ── UI ──
    textAlign(LEFT);
    textSize(35);
    text("學分 " + credit, 50, 50);
    String[] career_name = {"文學院", "理學院", "音樂學院", "藝術學院", "體育學院"};
    text(career_name[career], width - 150, 50);
    RunTimer();
}