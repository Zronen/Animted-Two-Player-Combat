/*
Sebastian Frank, June 12th, 2018
*/
Setup player1;
Setup player2;
HitBoxes p1;
HitBoxes p2;
boolean[]keys;
PImage img;  
PImage background1, splash;
//import processing.sound.*;
boolean start;

//SoundFile file;
//String audioName = "Battle Music.mp3";
//String path;
    
void setup() {
  size(1066,600); 
  player1 = new Setup(8,100,220, 6.5, 0); //speed, xpos, ypos, jumpheight, facial expression
   player2 = new Setup(9,900,220, 7.5, 0);
   p1 = new HitBoxes(player1.xpos, player1.ypos,player1.AnimType,0);
   p2 = new HitBoxes(player2.xpos, player2.ypos,player2.AnimType2,1);

   
//path = sketchPath(audioName);
//    file = new SoundFile(this, path);
  //  file.play();
    splash = loadImage("hibitodraglade2-2.jpg");
    background1 = loadImage("Pixel Mountains.png");
 player2.flip = true;
}

void draw() {
 //System.out.println(frameRate);
 //splashscreen for 3 seconds after program is initalized (NOTE: on slow computers this may not appear as it takes more than 3 seconds for the program to initaliaze)
 if (!start) {image(splash,1,0);} else {
  
  background(background1);
  //framerate is 50 for consistant speed. If framerate is too low then the game will lag
  frameRate(50);
 
 //if the game is over then one of these will be true
  if (!p1.win() && !p2.win()) {
  
    p1.Box(); 
     p1.hit(p2.atk1,p2.hit1);
    p1.lifebar(true);
   

 
   p2.Box(); 
   p2.hit(p1.atk1,p1.hit1);
   p2.lifebar(false);
  //player2.animeOpening2();
 
 
  }
   player1.animeguy1();
    player2.animeguy2();
     player1.pMove();
   player2.pMove();  
 }
}

//tracking what keys have been pressed or not, initial tirgger to actions
//NOTE Number of keys being able to be pressed down at a time is somewhat hardware dependant 
void keyPressed(){
  start = true;
  if(key == 'd'){
    player1.keys[0] = true;
  player1.flip = false;}
  if(key == 'a'){
    player1.keys[1] = true;
  player1.flip = true;}
  if(key == 'w'){
    player1.keys[2] = true;}
  if(key =='f'){
    if (!player1.keys[3]) {
      player1.attack = true;
    }
    player1.keys[3] = true;
  }
      if(key == 'g') {
 if (!player2.keys[4]) {
      player1.attack2 = true;
    }
   player1.keys[4] = true;
 }
 if(key == 's'){
    player1.keys[5] = true;
  //player1.block = true;
}
 
  if(keyCode == RIGHT){
    player2.keys[0] = true;
  player2.flip = false;}
  if(keyCode == LEFT){
    player2.keys[1] = true;
  player2.flip = true;}
  if(keyCode == UP){
    player2.keys[2] = true;}
   if(key == '/') {
 if (!player2.keys[3]) {
      player2.attack = true;
    }
   player2.keys[3] = true;
 }
 if(keyCode == DOWN){
    player2.keys[5] = true;
  //player2.block = true;
}

}
void keyReleased(){
  start = true;
  if(key == 'd'){
    player1.keys[0] = false;}
  if(key == 'a'){
    player1.keys[1] = false;}
  if(key == 'w'){
    player1.keys[2] = false;}
  if(key == 'f'){
    player1.keys[3] = false;}
  if(key == 'g'){
       player1.atkSpam = false;
    player1.keys[4] = false;}
  if(key == 's'){
    player1.keys[5] = false;
   player1.block = true;
}
  if(keyCode == RIGHT){
    player2.keys[0] = false;}
  if(keyCode == LEFT){
    player2.keys[1] = false;}
  if(keyCode == UP){
    player2.keys[2] = false;}
  if(key == '/'){
    player2.keys[3] = false;}
  if(keyCode == DOWN){
    player2.keys[5] = false;
    player2.block = true;
}
 }
