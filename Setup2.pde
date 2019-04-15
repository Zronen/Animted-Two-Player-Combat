class Setup {
  float xspeed; //how fast you go
  float xpos; //x position
  float ypos; //y position
  float floor; //y position of the ground
  float velocity; //velocity
  float jumpheight; //how high you jump
  float acceleration; //how fast you fall
boolean[] keys; //button press (a, s, d etc..)
boolean attack, attack2, block; //booleans for determining if a player is attacking or blocking
PImage spritesheet1; //first spritesheet (zeke)
PImage spritesheet2; //second spritesheet (hibito)
PImage hudimg; //img for the HUD
int DIM = 10; //box width of animation
int DIM2 = 30; //box height of animation
//arrays of images for each animation
PImage[] sprites = new PImage[DIM*DIM2];
PImage[] idleAnim = new PImage[8], runAnim = new PImage[6], jumpAnim = new PImage[5], openAnim = new PImage[25], atk1Anim = new PImage[4],
         atk2Anim = new PImage[4], arielAnim = new PImage[4], hidleAnim = new PImage[9], hrunAnim = new PImage[6], hjumpAnim = new PImage[5], hatk1Anim = new PImage[4], harielAnim = new PImage[4], openAnim2 = new PImage[31]; //number of sprites in animation
PImage[] cPic = new PImage[3], hcPic = new PImage[3];  
PImage painAnim = new PImage(), hpainAnim = new PImage(), blockAnim = new PImage(), hblockAnim = new PImage();
int hi; //loop counter for holding animations
int j; //loop check for animations
boolean flip; //determining if an image has been flipped or not
boolean atkSpam = false;
int AnimType, AnimType2; //Animation types = 0: idle 1: alt idle, 2: running, 3: alt running 4: attack1, 5: alt attack1, 6: attack2, 7: alt attack2, 8: ariel, 9: alt ariel, 10: jump, 11: alt jump, 12: taking damage, 13: blocking, 14: alt-blocking
int facetype; //what expression is shown by each character on the HUD
boolean damage; //if your taking damage or not
int savedTime; //millis
int totalTime = 2000; //how long an action will take place for 

  //Constructor
  Setup(float txspeed, float txpos, float typos, float jump, int face) {
    facetype = face;
    xspeed = txspeed;
    xpos = txpos;
    ypos = typos;
    jumpheight = jump;
    velocity = 0;
    floor = 220;
    acceleration = 15;
    keys = new boolean[6];
    keys[0] = false;
    keys[1] = false;
    keys[2] = false;
    keys[3] = false;
    attack = false;
    attack2 = false;
    block = false;
    spritesheet1= loadImage("ZekeC.png");
    spritesheet2= loadImage("HibitoC.png");
    hudimg = loadImage("Life Bar HUD.png");
    hi = 0;
    j = 0;    
    damage = false;;
    savedTime = millis();
    
    //corner picture
    cPic[0] = spritesheet1.get(750,3190, 60,40);
    cPic[1] = spritesheet1.get(750,3233, 60,40);
    cPic[2] = spritesheet1.get(750,3276, 60,40);
    
    //damage animation
    painAnim = spritesheet1.get(90,2557,69,62);
    
    //blocking animation
    blockAnim = spritesheet1.get(880,37,60,65);
      
    //opening animation
    int W0 = spritesheet1.width/DIM - 5; 
  int H0 = spritesheet1.height/DIM2;
  int q0; int r0;
  for (int i=0; i<25; i++) {
    q0 = 5 + 50 * i;
    r0 = 2760;
    if (i == 9 || i == 19) {r0 += 150; q0 = 0;}
    openAnim[i] = spritesheet1.get(q0, r0, W0, H0);}
    
    //idleing
    int W = spritesheet1.width/DIM - 5; //size of the actual box with the sprites in it
  int H = spritesheet1.height/DIM2 -2;
  int q;
  for (int i=0; i<8; i++) {
    q = 5 + 95 * i; //about how far sprite is from edge of sheet + average length of sprite
    idleAnim[i] = spritesheet1.get(q, 1, W, H);}

//running
  int H2 = spritesheet1.height/DIM2 -2;
int q2;
for (int i=0; i < 6; i++) {
  q2 = 9 + 62 * i;
runAnim[i] = spritesheet1.get(q2,105,50,H2);}

//jumping
  int q3;
  for (int i=0; i<5; i++) {
    if (ypos == floor) {q3 =0;}
    q3 = 15 + 67 * i; 
    jumpAnim[i] = spritesheet1.get(q3, 1680, 75, 78);}
    
//attack 1
 int H4 = spritesheet1.height/DIM2 -2;
  int q4;
  for (int i=0; i<4; i++) {
    q4 = 432 + 115 * i; 
    if (i == 0) {atk1Anim[0] = spritesheet1.get(468, 1040,80, H4);}
    else {
    atk1Anim[i] = spritesheet1.get(q4, 1040, 100, H4);}}
    
//attack 2
int H5 = spritesheet1.height/DIM2 -2;
  int q5;
  for (int i=0; i<4; i++) {
    q5 = 321 + 95 * i;
    if (i == 0) {atk2Anim[0] = spritesheet1.get(305,485,95,H5);}
  else {atk2Anim[i] = spritesheet1.get(q5, 485, 102, H5);}}
  
  //ariel
  int H6 = spritesheet1.height/DIM2 -2;
  int q6;
  for (int i=0; i<4; i++) {
    q6 = 78 + 120 * i; 
    if (i == 1) {arielAnim[1] = spritesheet1.get(220, 1805,90, H6);}
    else {
    arielAnim[i] = spritesheet1.get(q6, 1805, 126, H6);}}
    
  //Hibito damage animation
  hpainAnim = spritesheet2.get(7,3022,55,65);
    
  //Hibito blockin' animation
  hblockAnim = spritesheet2.get(720,336,60,77);
    
 //Hibito corner picture
    hcPic[0] = spritesheet2.get(520,3685, 55,40); 
    hcPic[1] = spritesheet2.get(520,3730, 55,40);
    hcPic[2] = spritesheet2.get(580,3685, 55,40);
    
//Hibito idle
  int hq1;
  for (int i=0; i<9; i++) {
    hq1 = 17 + 65 * i; 
    hidleAnim[i] = spritesheet2.get(hq1, 322, 75, 100);}
    
//Hibito running
  int hq2;
  for (int i=0; i<6; i++) {
    hq2 = 5 + 71 * i; 
    hrunAnim[i] = spritesheet2.get(hq2, 420, 70, 80);}
    
 //Hibito Jumping
 int hq3;
 for (int i = 0; i <5; i++) {
  hq3 = 4 + 63 * i;
  hjumpAnim[i] = spritesheet2.get(hq3, 950, 70, 100);}
  
  //Hibito attack 1
    int hq4;
  for (int i=0; i<4; i++) {
    hq4 = 3 + 75 * i; 
    if ((i == 2) || (i == 3)) {hatk1Anim[i] = spritesheet2.get((100 * i) - 39, 515,90, 100);}
    else {
    hatk1Anim[i] = spritesheet2.get(hq4, 515, 80, 100);}}
    
    //Hibito Ariel
 int hq6;
 for (int i = 0; i <4; i++) {
  hq6 = 550 + 90 * i;
  if (i == 3) {harielAnim[3] = spritesheet2.get(835, 635, 50, 100);}
  else {
  harielAnim[i] = spritesheet2.get(hq6, 635, 90, 100);}}
  
  //Hibito Opening

  
  //Unused Animation
  int hq0;
    for (int i = 0; i < 4; i++) {
    hq0 = 17 + 55 * i;
  openAnim2[i] = spritesheet2.get(hq0, 35, 60,80);}
     openAnim2[4] = spritesheet2.get(247, 35, 70, 80);
     for (int i = 5, r = 0; r < 3; i++, r++) {
    hq0 = 315 + 80 * r;
  openAnim2[i] = spritesheet2.get(hq0, 35, 65,80);}
  openAnim2[8] = spritesheet2.get(568, 35, 65,80);
  for (int i = 9, r = 0; r < 3; i++, r++) {
    hq0 = 648 + 73 * r;
  openAnim2[i] = spritesheet2.get(hq0, 35, 65,80);}
  openAnim2[12] = spritesheet2.get(20, 147, 65,75);
  openAnim2[13] = spritesheet2.get(90, 147, 65,75);
  openAnim2[14] = spritesheet2.get(165, 147, 65,75);
  openAnim2[15] = spritesheet2.get(240, 147, 65,75);
   for (int i = 16, r = 0; r < 3; i++, r++) {
    hq0 = 305 + 60 * r;
  openAnim2[i] = spritesheet2.get(hq0, 147, 65,80);}
  openAnim2[18] = spritesheet2.get(430, 110, 70, 100);
  
}


void animeOpening2() {
//unused Animation
    pushMatrix();
    scale(-1,1);
    image(openAnim2[(frameCount%961)/7], -xpos - 70, height - ypos +30, openAnim2[(frameCount%961)/7].width * 2, openAnim2[(frameCount%961)/7].height * 2);
    popMatrix();
  }
  
//player 1 animations
void animeguy1(){
  

 
  //corner pictures
 { textSize(28);
 fill(100,100,100);}
 image(hudimg,20,50, hudimg.width * 1.5, hudimg.height * 1.5);
  text("Zeke", 20, 50);
  
  
  
  pushMatrix();
    scale(-1,1);
  image(cPic[facetype], -135 , 57, cPic[facetype].width * 1.3, cPic[facetype].height * 1.3);
  popMatrix();
  
  //taking damage
  if(p1.overlap == true){
    AnimType = 12;
    damage = true;
    if (flip == false) {
    if (player2.xpos > player1.xpos) {
   image  (painAnim,xpos + 40, height - ypos + 62 ,painAnim.width*2, painAnim.height*2);
   xpos -=0.2;
 }
   else {
    pushMatrix();
    scale(-1,1);
    image  (painAnim, -xpos - 150, height - ypos + 62 ,painAnim.width*2, painAnim.height*2);
    popMatrix();
    xpos += 0.2;
   }
    }
  else {
      if (player2.xpos > player1.xpos) {
   image  (painAnim,xpos - 90, height - ypos + 62 ,painAnim.width*2, painAnim.height*2); 
 xpos -= 0.2;}
   else {
    pushMatrix();
    scale(-1,1);
    image  (painAnim, -xpos - 30, height - ypos + 62 ,painAnim.width*2, painAnim.height*2);
    popMatrix();
    xpos += 0.2;
   }
  }
    
       
   attack = false;
   attack2 = false;
   facetype = 1; 
  }
  
  
  //blocking
    else if (block && ypos <= floor) {
    facetype = 0;
    if (flip == true) {
      AnimType = 14;
     pushMatrix();
     scale(-1,1);
       image(blockAnim, -xpos - 80, height - ypos + 60, blockAnim.width * 2, blockAnim.height * 2);
      popMatrix();
    }
      else {
        AnimType = 13;
    image(blockAnim, xpos, height - ypos + 60, blockAnim.width * 2, blockAnim.height * 2);
  }
   attack = false;
   attack2 = false;
   //blocking timer (blocks for 1 second)
    int passedTime = millis() - savedTime;
   if (passedTime > totalTime) {
    block = !block; 
    savedTime = millis();
   }
  }
  
  //attack1
  else if (attack && (ypos <= floor)) {
    facetype = 2;
    if (flip == true) {
      pushMatrix();
    scale(-1,1);
   image(atk1Anim[(hi%16)/4], -xpos -80, height - ypos +20, atk1Anim[(hi%16)/4].width * 2, atk1Anim[(hi%16)/4].height * 2);
    popMatrix();
     if (hi == 6) {
      AnimType = 5;
    }
   }
    else {
    image(atk1Anim[(hi%16)/4], xpos, height - ypos +20, atk1Anim[(hi%16)/4].width * 2, atk1Anim[(hi%16)/4].height * 2);
   if (hi == 6) {
      AnimType = 4;
    }
  }
    hi++;
    if (hi >= 16) {
      hi = 15; //<>//
      j++;
      if (j > 5) {
        attack = false;
        j = 0;
        hi = 0;
      }
      
    }}
    
    //attack 2
   else if(attack2 && (/*(ypos <= floor) && */(atkSpam == false))) {
     facetype = 2;
      if (flip == true) {

      pushMatrix();
    scale(-1,1);
     image(atk2Anim[(hi%16)/4], -xpos- 100, height - ypos +70, atk2Anim[(hi%16)/4].width * 2, atk2Anim[(hi%16)/4].height * 2);
    popMatrix();
   if (hi == 4) {
      AnimType = 7;
    }  
}
    else {
      image(atk2Anim[(hi%16)/4], xpos, height - ypos +70, atk2Anim[(hi%16)/4].width * 2, atk2Anim[(hi%16)/4].height * 2);
   if (hi == 4) {
      AnimType = 6;
    }   
  }
    hi++;
    if (hi >= 16) {
      hi = 15;
      j++;
      if (j > 5) {
        attack = false;
        attack2 = false;
        atkSpam = true;
        j = 0;
        hi = 0;
      }
      
    }
    }
   
    //ariel
 else if(attack && (ypos > floor)) {
   facetype = 2;
   if (flip == true) {
     AnimType = 9;
      pushMatrix();
    scale(-1,1);
    image(arielAnim[(hi%16)/4], -xpos - 180, height - ypos +20, arielAnim[(hi%16)/4].width * 2, arielAnim[(hi%16)/4].height * 2);
    popMatrix();
   }
   else {
     AnimType = 8;
      image(arielAnim[(hi%16)/4], xpos, height - ypos +20, arielAnim[(hi%16)/4].width * 2, arielAnim[(hi%16)/4].height * 2); }
    hi++;
    if (hi >= 16) {
      hi = 15;
      j++;
      if (j > 5) {
        attack = false;
        attack2 = false;
        j = 0;
        hi = 0;
      }
      
    }
    }
    
    //jumping
    else if (ypos > floor){
      facetype = 0;
    if (flip == true) { 
      AnimType = 11;
    pushMatrix();
    scale(-1,1);
    image(jumpAnim[(frameCount%25)/5], -xpos - 70, height - ypos, jumpAnim[(frameCount%25)/5].width * 2, jumpAnim[(frameCount%25)/5].height * 2); 
    popMatrix();
    }  
    else {
      AnimType = 10;
      image(jumpAnim[(frameCount%25)/5], xpos, height - ypos, jumpAnim[(frameCount%25)/5].width * 2, jumpAnim[(frameCount%25)/5].height * 2); 
    }
  }
  //running
  else if (keys[0]) { 
    facetype = 0;
    AnimType = 2;
    image(runAnim[(frameCount%36)/6], xpos, height - ypos, runAnim[(frameCount%36)/6].width * 2, runAnim[(frameCount%36)/6].height * 2);
  } 
  else if (keys[1]) {
    facetype = 0;
    AnimType = 3;
 pushMatrix();
    scale(-1,1);
    image(runAnim[(frameCount%36)/6], -xpos - 70, height - ypos, runAnim[(frameCount%36)/6].width * 2, runAnim[(frameCount%36)/6].height * 2);
  popMatrix();
  } 
  
  //idleing
  else {
    facetype = 0;
    if (flip == true) {
      AnimType = 1;
     pushMatrix();
     scale(-1,1);
      image(idleAnim[(frameCount%64)/8], -xpos - 70, height - ypos - 10, idleAnim[(frameCount%64)/8].width * 2, idleAnim[(frameCount%64)/8].height * 2);
      popMatrix();
    }
      else {
        AnimType = 0;
    image(idleAnim[(frameCount%64)/8], xpos, height - ypos - 10, idleAnim[(frameCount%64)/8].width * 2, idleAnim[(frameCount%64)/8].height * 2); }//What the image is, xposition, yposition, size, size
  }

}

//Player 2 animation calling
 void animeguy2() {
   
   { textSize(28);
   fill(200,0,0);}
  text("Hibito", 960, 50);
  
  
   pushMatrix();
    scale(-1,1);
    
  image(hudimg,-1050, 50, hudimg.width * 1.5, hudimg.height * 1.5); 
  image(hcPic[facetype], -1010 , 55, hcPic[facetype].width * 1.5, hcPic[facetype].height * 1.5);
  popMatrix();
   
 //h taking damage  
    if (p2.overlap == true){
      AnimType2 = 12;
      damage = true;
      if (flip == true) {
    if (player1.xpos > player2.xpos) {
   image  (hpainAnim,xpos - 50, height - ypos + 62 ,hpainAnim.width*2, hpainAnim.height*2); 
   xpos -= 0.2;
 }
   else {
    pushMatrix();
    scale(-1,1);
    image  (hpainAnim, -xpos - 50, height - ypos + 62 ,hpainAnim.width*2, hpainAnim.height*2);
    popMatrix();
    xpos += 0.2;
   }
      }
   if (flip == false) {
         if (player1.xpos > player2.xpos) {
   image  (hpainAnim,xpos + 30, height - ypos + 62 ,hpainAnim.width*2, hpainAnim.height*2); 
   xpos -= 0.2;
 }
   else {
    pushMatrix();
    scale(-1,1);
    image  (hpainAnim, -xpos - 120, height - ypos + 62 ,hpainAnim.width*2, hpainAnim.height*2);
    popMatrix();
    xpos += 0.2;
   }
    }
      
   attack = false;
   attack2 = false;
   facetype = 1; 
  }
  
  
  // h blocking
    else if (block && (ypos <= floor)) {
    facetype = 0;
    if (flip == true) {
      AnimType2 = 14;
     pushMatrix();
     scale(-1,1);
       image(hblockAnim, -xpos - 65, height - ypos + 37, hblockAnim.width * 2, hblockAnim.height * 2);
      popMatrix();
    }
      else {
        AnimType2 = 13;
    image(hblockAnim, xpos, height - ypos + 37, hblockAnim.width * 2, hblockAnim.height * 2);
  }
   attack = false;
   attack2 = false;
    //h blocking timer (blocks for 1 second)
    int passedTime = millis() - savedTime;
   if (passedTime > totalTime) {
    block = !block; 
    savedTime = millis();
   }
  }
   
   // h attack 1
  else if (attack && (ypos <= floor) && atkSpam == false) {
     facetype = 2;
    if (flip == true) {
      
      pushMatrix();
    scale(-1,1);
   image(hatk1Anim[(hi%16)/4], -xpos -70, height - ypos +20, hatk1Anim[(hi%16)/4].width * 2, hatk1Anim[(hi%16)/4].height * 2);
    popMatrix();
    if (hi == 10) {
     AnimType2 = 5; 
    }
    
   }
    else {

    image(hatk1Anim[(hi%16)/4], xpos, height - ypos +20, hatk1Anim[(hi%16)/4].width * 2, hatk1Anim[(hi%16)/4].height * 2); 
  if (hi == 10) {
     AnimType2 = 4; 
    }  
}
    hi++;
    if (hi >= 16) {
      hi = 15;
      j++;
      if (j > 5) {
        attack = false;
        j = 0;
        hi = 0;
      }
    }
   }
     
     //h ariel
  else if(attack && (ypos > floor) && atkSpam == false) {
    facetype = 2;
   if (flip == true) {
     AnimType2 = 9;
      pushMatrix();
    scale(-1,1);
    image(harielAnim[(hi%16)/4], -xpos - 70, height - ypos +20, harielAnim[(hi%16)/4].width * 2, harielAnim[(hi%16)/4].height * 2);
    popMatrix();
   }
   else {
     facetype = 2;
     AnimType2 = 8;
   image(harielAnim[(hi%16)/4], xpos, height - ypos +20, harielAnim[(hi%16)/4].width * 2, harielAnim[(hi%16)/4].height * 2); }
    hi++;
    if (hi >= 16) {
      hi = 15;
      j++;
      if (j > 5) {
        attack = false;
        j = 0;
        hi = 0;
      } 
    }
    }
    
    //h jumping
     else if (ypos > floor) {
       facetype = 0;
     if (flip == true) {
       AnimType2 = 11;
      pushMatrix();
    scale(-1,1);
    image(hjumpAnim[(frameCount%25)/5], -xpos - 70, height - ypos, hjumpAnim[(frameCount%25)/5].width * 2, hjumpAnim[(frameCount%25)/5].height * 2); 
    popMatrix(); }
    else {
      AnimType2 = 10;
     image(hjumpAnim[(frameCount%25)/5], xpos, height - ypos, hjumpAnim[(frameCount%25)/5].width * 2, hjumpAnim[(frameCount%25)/5].height * 2); }}
   
   //h running
  else if (keys[0]){
    facetype = 0;
     AnimType2 = 2;
   image(hrunAnim[(frameCount%36)/6], xpos, height - ypos +30, hrunAnim[(frameCount%36)/6].width * 2, hrunAnim[(frameCount%36)/6].height * 2); }
   
   else if (keys[1]) {
     facetype = 0;
     AnimType2 = 3;
      pushMatrix();
    scale(-1,1);
    image(hrunAnim[(frameCount%36)/6], -xpos - 70, height - ypos +30, hrunAnim[(frameCount%36)/6].width * 2, hrunAnim[(frameCount%36)/6].height * 2);
    popMatrix();}
   
   //h idleing
   else {
     facetype = 0;
     if(flip == true) {
       AnimType2 = 1;
        pushMatrix();
    scale(-1,1);
   image(hidleAnim[(frameCount%81)/9], -xpos - 70, height - ypos +10, hidleAnim[(frameCount%81)/9].width * 2, hidleAnim[(frameCount%81)/9].height * 2);
    popMatrix();
  }
     
     else {
       AnimType2 = 0;
    image(hidleAnim[(frameCount%81)/9], xpos, height - ypos +10, hidleAnim[(frameCount%81)/9].width * 2, hidleAnim[(frameCount%81)/9].height * 2); }
  }
  
 }
 
 


  public void pMove() {
    //moving left and right
      if (keys[0] && ((!attack || ypos > floor)) && !block && (!damage)) {
        xpos += xspeed;
        if (ypos > floor) {
        xpos += xspeed/2;}
       xpos = Math.abs(xpos);
      }
      
      if (keys[1] && ((!attack || ypos > floor)) && !block && (!damage)) {
        xpos -= xspeed;
        if (ypos > floor) {
        xpos -= xspeed/2;}

      }
     

     //jumping
      if ((keys[2]) && (ypos == floor) && !attack && !block && (!damage)) {
        velocity = jumpheight;
      }

    if (xpos > 985) {
      xpos = 984;
    } 

    if (xpos <20) {
      xpos = 21;}
    ypos += velocity * 100 / frameRate;
    
    if (ypos > floor) {
      velocity -= acceleration / frameRate;
    }

    else {
      velocity = 0;
      ypos = floor;
    }
}
}
