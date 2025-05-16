



class JobResultDisplay {
  PImage[] workers;
  PImage[] jobScene;
  PFont TCFontBold;
  
  // 職業資訊
  String[] jobTitles = {"律師", "科學家", "音樂家", "畫家", "運動員"};
  color[] textColors = {#D9D9D9, #AF9224, #D0BAE5, #932E2E, #668C86};
  color[] textBgColors = {color(255), color(0), color(255), color(0), color(0)};
  int[] textX = {380, 400, 400, 400, 612};
  int textY = 100;
  int titleY = 180;
  int[] workerX = {626, 653, 159, 516, 583};
  int[] workerY = {499, 416, 458, 504, 549};
  int[] workerWidth = {515, 520, 373, 504, 381};
  int[] workerHeight = {515, 520, 373, 504, 381};
  String congratsText = "恭喜你成功畢業\n成為";
  
  
  JobResultDisplay() {
    workers = new PImage[5];
    jobScene = new PImage[5];
    
    // 載入圖片
    workers[0] = loadImage("job_data/worker1.png");
    workers[1] = loadImage("job_data/worker2.png");
    workers[2] = loadImage("job_data/worker3.png");
    workers[3] = loadImage("job_data/worker4.png");
    workers[4] = loadImage("job_data/worker5.png");
    
    jobScene[0] = loadImage("job_data/job_scene1.png");
    jobScene[1] = loadImage("job_data/job_scene2.png");
    jobScene[2] = loadImage("job_data/job_scene3.jpg");
    jobScene[3] = loadImage("job_data/job_scene4.png");
    jobScene[4] = loadImage("job_data/job_scene5.jpg");
    
    // 載入字體
    TCFontBold = createFont("job_data/NotoSansTC-Bold.ttf", 30);
  }
  
  // 顯示指定職業的結果畫面
  void displayJob(int jobNumber) {
    // 繪製背景場景
    imageMode(CENTER);
    image(jobScene[jobNumber], 400, 400, 800, 800);
    
    // 繪製人物
    image(workers[jobNumber], workerX[jobNumber], workerY[jobNumber], workerWidth[jobNumber], workerHeight[jobNumber]);
    
    // 繪製文字
    textFont(TCFontBold);
    textAlign(CENTER, CENTER);
    textSize(36);
    fill(textBgColors[jobNumber]);
    text(congratsText, textX[jobNumber], textY);
    
    textSize(64);
    fill(textColors[jobNumber]);
    text(jobTitles[jobNumber], textX[jobNumber], titleY);
  }
}
