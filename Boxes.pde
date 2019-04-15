class Boxes {
   float xbody, ybody, xatk, yatk, width1, height1, playchoose;
 int gothit = 0;
int aType;

  
//Constructor 
  Boxes() {
    this.xbody = 0;
    this.ybody = 0;
    this.width1 = 0;
    this.height1 = 0;
  }

  Boxes (float xx, float yy, int aTy, int player) {
    this.xbody = xx;
    this.ybody = 1066 - yy + 50;
    this.aType = aTy;
    this.playchoose = player;
    float width1;
    float height1;
    
  }

}
