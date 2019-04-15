class HitBoxes extends Boxes {
 float xbody, ybody, xatk, yatk, width1, height1, playchoose;
 int gothit = 0;
int aType;
  Boxes atk1 = new Boxes();
  Boxes hit1 = new Boxes();
boolean overlap = true;  
float dmg;
int savedTime;
int totalTime = 1000;
float hp = 294;
PImage winPic = new PImage();
  
  //Constructor 
  HitBoxes() {
    this.xbody = 0;
    this.ybody = 0;
    this.width1 = 0;
    this.height1 = 0;
  }

  HitBoxes (float xx, float yy, int aTy, int player) {
    this.xbody = xx;
    this.ybody = 1066 - yy + 50;
    this.aType = aTy;
    this.playchoose = player;
    dmg = 0;
    savedTime = millis();
    overlap = false;
    hp = 292;
    winPic = loadImage("Sea Background.2jpg.jpg");
  }
  
  
  void hit(Boxes atk, Boxes hit) {
    int passedTime = millis() - savedTime;
   
      
    if((hit1.xbody > (atk.xbody + atk.width1)) || (hit1.ybody > (atk.ybody + atk.height1)) || ((hit1.xbody + hit1.width1) < atk.xbody) || ((hit1.ybody + hit1.height1) < atk.ybody))
    { 
      if (passedTime > totalTime) {
      overlap = false;
   // println("false");
    savedTime = millis();
    player1.damage = false;
    player2.damage = false;
      }
  }
    else {
      overlap = true;
   // println("true");

  hp = 294 - dmg;
}

  }
  
  public boolean win() {
      if (hp < 0) {
    image(winPic,1,0);
    if (p1.dmg > p2.dmg) {
      textSize(28); 
      text("Player 2 (Hibito) Wins!", 400, 50);
    }
    else {
      text("Player 1 (Zeke) Wins!", 400, 50);
    }
    return true;   
      }
    else return false;
  }
  
  void lifebar(boolean player){
   
     if (playchoose == 0) {
      aType = player1.AnimType;}
      else {
        aType = player2.AnimType2;}
    
    if (overlap == true) {
      if ((aType == 4) || (aType == 5)) {
  dmg += 0.5;
  }
  else if ((aType == 6) || (aType == 7)) {
  dmg += 0.3;
  }
  else {
  dmg += 0.5;
  }
    }
    
   if (player) {
     fill(50 + dmg,255 - dmg/1.5,0);
     rect(150,90,292 - dmg,20);
   }
    else {
      fill(50 + dmg,255 - dmg/1.5,0);
      rect(920, 90, -292 + dmg,20);
    }
    noFill();

  }
  
  void Box() {
    
  
    //setting up which player variables to access
   if (playchoose == 0) { 
   xbody = player1.xpos;
   ybody = height - player1.ypos + 50;
   aType = player1.AnimType;
   }
   else {
     xbody = player2.xpos;
     ybody = height - player2.ypos + 50;
     aType = player2.AnimType2;
   }
   noFill();
   noStroke();
   
   //idle
    if ((aType == 0)) {
    if (playchoose == 0) {
    rect(xbody + 50,ybody,80,150);
    hit1.xbody = xbody + 50;   hit1.ybody = ybody;    hit1.width1 = 80;    hit1.height1 = 150;
      }
    else {
      rect(xbody + 40 ,ybody,80,150);
    hit1.xbody = xbody + 40; hit1.ybody = ybody; hit1.width1 = 80; hit1.height1 = 150;
      }
      atk1.xbody = 0; atk1.ybody = 0; atk1.width1 = 0; atk1.height1 = 0;
    }
    else if (aType == 1) {
      if (playchoose == 0) {
    rect(xbody - 70,ybody,80,150); 
    hit1.xbody = xbody - 70; hit1.ybody = ybody; hit1.width1 =  80; hit1.height1 = 150;
      }
      else {
       rect(xbody - 50,ybody,80,150); 
       hit1.xbody = xbody - 50; hit1.ybody = ybody; hit1.width1 = 80; hit1.height1 = 150;
      }
      
      atk1.xbody = 0; atk1.ybody = 0; atk1.width1 = 0; atk1.height1 = 0;
    }
    
    //running
    else if (aType == 2) {
      if (playchoose == 0) {
     rect(xbody,ybody,100,150);
     hit1.xbody = xbody; hit1.ybody = ybody; hit1.width1 = 100; hit1.height1 = 150;
   }
   else {
    rect(xbody + 20,ybody,80,150);
    hit1.xbody = xbody + 20; hit1.ybody = ybody; hit1.width1 = 80; hit1.height1 = 150;
   }
      atk1.xbody = 0; atk1.ybody = 0; atk1.width1 = 0; atk1.height1 = 0;
    }
    else if (aType == 3) {
      if (playchoose == 0) {
     rect(xbody - 40,ybody,100,150);
     hit1.xbody = xbody - 40; hit1.ybody = ybody; hit1.width1 = 100; hit1.height1 = 150;
      }
      else {
     rect(xbody - 40,ybody,80,150); 
     hit1.xbody = xbody - 40; hit1.ybody = ybody; hit1.width1 = 80; hit1.height1 = 150;
      }
      atk1.xbody = 0; atk1.ybody = 0; atk1.width1 = 0; atk1.height1 = 0;
    }
    
    //attack 1
    else if (aType == 4) {
      if (playchoose == 0) {
      rect(xbody,ybody,100,150);
       hit1.xbody = xbody; hit1.ybody = ybody; hit1.width1 = 100; hit1.height1 = 150;
      rect(xbody + 100 ,ybody + 50,100,80);
      atk1.xbody = xbody + 100; atk1.ybody = ybody + 50; atk1.width1 = 100; atk1.height1 = 80;
      }
      else {
      rect(xbody,ybody,80,150);
       hit1.xbody = xbody; hit1.ybody = ybody; hit1.width1 = 80; hit1.height1 = 150;
       rect(xbody + 80 ,ybody + 50,100,80); 
       atk1.xbody = xbody + 92; atk1.ybody = ybody + 50; atk1.width1 = 100; atk1.height1 = 80;
      }
    }
   else if (aType == 5) {
     if (playchoose == 0) {
      rect(xbody - 40,ybody,100,150);
      hit1.xbody = xbody - 40; hit1.ybody = ybody; hit1.width1 = 100; hit1.height1 = 150;
      rect(xbody -120,ybody + 50,80,80);
      atk1.xbody = xbody - 120; atk1.ybody = ybody + 50; atk1.width1 = 80; atk1.height1 = 80;
     }
     else {
      rect(xbody,ybody,80,150);
      hit1.xbody = xbody; hit1.ybody = ybody; hit1.width1 = 80; hit1.height1 = 150;
      rect(xbody - 100 ,ybody + 50,100,80); 
      atk1.xbody = xbody - 112; atk1.ybody = ybody + 50; atk1.width1 = 100; atk1.height1 = 80;
     }
   }
   
   //attack 2
   else if (aType == 6) {
      rect(xbody + 30,ybody + 70,140,70);
      hit1.xbody = xbody + 30; hit1.ybody = ybody + 70; hit1.width1 = 140; hit1.height1 = 70;
      rect(xbody + 70,ybody + 60, 120,70);
      atk1.xbody = xbody + 70; atk1.ybody = ybody + 60; atk1.width1 = 120; atk1.height1 = 70;
   }
   else if (aType == 7) {
    rect(xbody - 50,ybody + 70,140,70);
    hit1.xbody = xbody - 50; hit1.ybody = ybody + 70; hit1.width1 = 140; hit1.height1 = 70;
    rect(xbody - 90,ybody + 60, 120,70); 
    atk1.xbody = xbody - 90; atk1.ybody = ybody + 60; atk1.width1 = 120; atk1.height1 = 70;
   }
   
   //ariel
   else if (aType == 8) {
     if (playchoose == 0) {
    rect(xbody + 60,ybody - 20,100,140);
    hit1.xbody = xbody + 60; hit1.ybody = ybody - 20; hit1.width1 = 100; hit1.height1 = 140;
    rect(xbody + 20, ybody - 10, 200,80); 
    atk1.xbody = xbody + 20; atk1.ybody = ybody - 10; atk1.width1 = 200; atk1.height1 = 80; //
     }
     else {
     rect(xbody,ybody + 10, 90,110);
      hit1.xbody = xbody; hit1.ybody = ybody + 10; hit1.width1 = 90; hit1.height1 = 110;
     rect(xbody + 90,ybody,80,120);
     atk1.xbody = xbody + 90; atk1.ybody = ybody; atk1.width1 = 80; atk1.height1 = 120;
     }
   }
   else if (aType == 9) {
     if (playchoose ==0) {
   rect(xbody + 10,ybody - 20,100,140);
   hit1.xbody = xbody + 10; hit1.ybody = ybody - 20; hit1.width1 = 100; hit1.height1 = 140;
   rect(xbody - 40, ybody,200,80); 
   atk1.xbody = xbody - 40; atk1.ybody = ybody; atk1.width1 = 200; atk1.height1 = 80; //
   }
   else {
     rect(xbody,ybody + 10, 90,110);
     hit1.xbody = xbody + 10; hit1.ybody = ybody + 10; hit1.width1 = 90; hit1.height1 = 110;
     rect(xbody - 80,ybody,80,120);
     atk1.xbody = xbody - 80; atk1.ybody = ybody; atk1.width1 = 80; atk1.height1 = 120;
     }
   }
   
   //jumping
   else if (aType == 10) {
     if (playchoose == 0) {
    rect(xbody + 25,ybody - 30, 100,130); 
    hit1.xbody = xbody + 25; hit1.ybody = ybody - 30; hit1.width1 = 100; hit1.height1 = 130;
   }
   else {
     rect(xbody + 35,ybody + 20,80,120);
      hit1.xbody = xbody + 35; hit1.ybody = ybody + 20; hit1.width1 = 80; hit1.height1 = 120;
     }
   }
   else if (aType == 11) {
     if (playchoose == 0){
    rect(xbody - 50,ybody - 30, 100,130); 
    hit1.xbody = xbody - 50; hit1.ybody = ybody - 30; hit1.width1 = 100; hit1.height1 = 130;
     }
     else {
      rect(xbody - 40,ybody + 20,80,120); 
      hit1.xbody = xbody + 40; hit1.ybody = ybody + 20; hit1.width1 = 80; hit1.height1 = 120;
     }
   }
   //taking damage
   else if (aType == 12) {
     if (playchoose == 0) {
      hit1.xbody = 0; hit1.ybody = 1; hit1.width1 = 0; hit1.height1 = 0;
    }
      else{
       hit1.xbody = 1; hit1.ybody = 0; hit1.width1 = 0; hit1.height1 = 0; 
      }
     }
     //blocking
   else if ((aType == 13) || (aType == 14)) {
    if (playchoose == 0) {
    hit1.xbody = 0; hit1.ybody = 1; hit1.width1 = 0; hit1.height1 = 0;
    }
    else {
    hit1.xbody = 1; hit1.ybody = 0; hit1.width1 = 0; hit1.height1 = 0;
    }
    
   }
   
  }

}
