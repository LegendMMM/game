import ddf.minim.*;                                  //★

// ─── 全域資源 ───
PImage book, timer, computer, pen, music, yaling, backgroundImg, playerL, playerR;
PFont  TCFont;
Minim  minim;
AudioPlayer bgm;

// ─── 全域狀態 ───
int t = 0, T = 0;            // 計時
int v = 10;                  // 速度上限
int credit = 45;              // 學分
int stage = -1;              // -1:開場 0:白天 1:商店 2:結束w
int level = 1;               // 商店購買次數
int weapon_mode = 0;         // 武器位元狀態
int mode3_CD = 0;            // 散射冷卻
int face = 0;                // 0:右 1:左
int temp = 0;                // 商店防誤觸計時

Player_id            Player_id = new Player_id(new PVector(0, 0), new PVector(0, 0), 10, 10);
ArrayList<Weapon_id> Weapon_id = new ArrayList<Weapon_id>();
ArrayList<Monster_id> Monster   = new ArrayList<Monster_id>();

// ─── Start ───
void setup() {
    minim = new Minim(this);
    bgm   = minim.loadFile("data/音樂.mp3");
    bgm.loop();

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
    backgroundImg = loadImage("pic/background.PNG");
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
    RunTimer();
}