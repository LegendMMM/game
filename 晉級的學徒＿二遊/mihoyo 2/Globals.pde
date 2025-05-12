/*  全域資源・狀態變數  */
import ddf.minim.*;

PImage book, timer, computer, pen, music, yaling, backgroundImg, playerL, playerR;
PFont  TCFont;

Minim minim;
AudioPlayer bgm;

/* ----- 遊戲狀態 ----- */
int t = 0, T = 0;         // 幀計數 → 秒
int v = 10;               // 玩家最大速度
int credit = 0;           // 取得學分
int stage  = -1;          // -1: 標題, 0: 早晨, 1: 商店, 2: 結束
int level  = 1;           // 商店購買次數
int weapon_mode = 0;      // 五種武器位元開關
int mode3_CD = 0;         // Mode‑3 冷卻
int face = 0;             // 0→右 , 1→左
int temp = 0;             // 商店用 internal timer

/* ----- 物件容器 ----- */
Player             player   = new Player(new PVector(0, 0),
                                         new PVector(0, 0), 10, 10);
ArrayList<Weapon>  weapons  = new ArrayList<Weapon>();
ArrayList<Monster> monsters = new ArrayList<Monster>();