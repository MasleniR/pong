int difficultyModifier = 1;
float ballVelocity = 10;
boolean wp, upp, sp, downp, startGame, endGame;
int rpaddleX, paddleHeight, lpaddleY, rpaddleY, ballX, ballY, paddleVelocity, lpaddleX, paddleWidth, directionCoefficient;
int ballRadius;
float currentBallVelocityX, currentBallVelocityY;
float rootTwo = sqrt(2);
int score1, score2 = 0;
int victoryScore = 0;

void setup(){
  frameRate(60);
size(1000, 900);
lpaddleX = width/20;
rpaddleX = width-lpaddleX;
ballX = width/2;
ballY = height/2;
ballStart();
lpaddleY=height/2-paddleHeight/2;
rpaddleY=height/2-paddleHeight/2;
drawElements();
}

void draw(){
  background(0);
  gameEnd();
  score();
  drawElements();
if(startGame){
paddleMovement();
ballMovement();
ballBounce();
}else{
openingPhase();
}
}

void drawElements(){
  ballRadius = 20;
  paddleHeight = height/(6*difficultyModifier);
paddleWidth = paddleHeight/8;
rect(lpaddleX, lpaddleY, paddleWidth, paddleHeight);
rect(width-lpaddleX, rpaddleY, paddleWidth, paddleHeight);
circle(ballX, ballY, ballRadius);
rect(0, height-4, width, 4);
rect(0, 0, width, 4);

}

void keyPressed(){
if (key == 'w' || key == 'W'){
  wp = true;
}
if (key == 's' || key == 'S'){
   sp = true;
}
if (keyCode == UP){
  upp = true;
}
if (keyCode == DOWN){
 downp = true;
}
}

void keyReleased(){
if (key == 'w' || key == 'W'){
  wp = false;
}
if (key == 's' || key == 'S'){
   sp = false;
}
if (keyCode == UP){
  upp = false;
}
if (keyCode == DOWN){
 downp = false;
}
}

void paddleMovement(){
  paddleVelocity = height/80*difficultyModifier;

if (wp && (lpaddleY>=4)){
lpaddleY-=paddleVelocity;
}

if (sp && (lpaddleY+paddleHeight<=height-4)){
lpaddleY+=paddleVelocity;
}

if (upp && (rpaddleY>=4)){
rpaddleY-=paddleVelocity;
}

if (downp && (rpaddleY+paddleHeight<=height-4)){
rpaddleY+=paddleVelocity;
}
}

void ballStart(){
directionCoefficient=round(random(-0.5 , 3.5));
if (directionCoefficient == 0){
currentBallVelocityX=random(3, ballVelocity/rootTwo);
currentBallVelocityY=random(3, ballVelocity/rootTwo);
}else if(directionCoefficient == 1){
currentBallVelocityX=random(-ballVelocity/rootTwo, -3);
currentBallVelocityY=random(3, ballVelocity/rootTwo);
}else if(directionCoefficient == 2){
currentBallVelocityX=random(3, ballVelocity/rootTwo);
currentBallVelocityY=random(-ballVelocity/rootTwo, -3);
}else if(directionCoefficient == 3){
currentBallVelocityX=random(-ballVelocity/rootTwo, -3);
currentBallVelocityY=random(-ballVelocity/rootTwo, -3);
}
}

void ballMovement(){
   ballX+=round(currentBallVelocityX);
   ballY+=round(currentBallVelocityY);
   if ((currentBallVelocityX < ballVelocity/rootTwo) && (currentBallVelocityX > -ballVelocity/rootTwo)){
     if (ballVelocity/rootTwo - abs(currentBallVelocityX) <= 1){
       if (currentBallVelocityX > 0){
     currentBallVelocityX = ballVelocity/rootTwo;
   }
     else{currentBallVelocityX = -ballVelocity/rootTwo;
   }
     }else if(currentBallVelocityX >= 0){
     currentBallVelocityX += (ballVelocity/rootTwo - currentBallVelocityX)/180;
     }else{
     currentBallVelocityX -= (ballVelocity/rootTwo - abs(currentBallVelocityX))/180;
     }
   }
   if ((currentBallVelocityY < ballVelocity/rootTwo) && (currentBallVelocityY > -ballVelocity/rootTwo)){
     if (ballVelocity/rootTwo - abs(currentBallVelocityY) <= 1){
       if(currentBallVelocityY > 0){
     currentBallVelocityY = ballVelocity/rootTwo;
   }else{currentBallVelocityY = - ballVelocity/rootTwo;}
     }else if(currentBallVelocityY >= 0){
     currentBallVelocityY += (ballVelocity/rootTwo - currentBallVelocityY)/180;
     }else{
     currentBallVelocityY -= (ballVelocity/rootTwo - abs(currentBallVelocityY))/180;
     }
   }
}

    void openingPhase(){
  textSize(60);
text("Press Enter to start game", width/5-50, height/2-40);
textSize(45);
text("Select difficulty(1, 2, 3)", width/5 + 50, 100);
textSize(30);
    text("Press 4, 5 or 6 on the numpad to change the victory score", 100, height-200);
    textSize(25);
    text("(victory score is set to infinity by default, 5, 10 or 15 otherwise)", 100, height - 125);
if (key == '1'){
difficultyModifier = 1;
}
if (key == '2'){
difficultyModifier = 2;
}
if (key == '3'){
difficultyModifier = 3;
}
if (keyCode == 100){
victoryScore = 5;
}
if (keyCode == 101){
victoryScore = 10;
}
if (keyCode == 102){
victoryScore = 15;
}
if (keyCode == 10){
startGame = true;
}
lpaddleY=height/2-paddleHeight/2;
rpaddleY=height/2-paddleHeight/2;
}
    
    void ballBounce(){
      if (((ballY - ballRadius >= 4 + round(currentBallVelocityY)) && (ballY - ballRadius < 4 - round(currentBallVelocityY))) || ((ballY + ballRadius <= height + round(currentBallVelocityY) - 4) && (ballY + ballRadius > height - round(currentBallVelocityY) - 4))){
      currentBallVelocityY*=-1;
      }
      
   if(((((ballX - ballRadius - lpaddleX) <= 0) && (ballX - ballRadius - lpaddleX) > round(currentBallVelocityX)) && ((ballY >= lpaddleY) &&( ballY <= lpaddleY + paddleHeight))) || ((((width - (paddleWidth + lpaddleX) - ballX) <= 0) && ((width - (paddleWidth +lpaddleX) - ballX) > -round(currentBallVelocityX))) && ((ballY >= rpaddleY) &&( ballY <= rpaddleY + paddleHeight)))){
   currentBallVelocityX*=-1;
     if (currentBallVelocityY > 0){
   currentBallVelocityY+=paddleVelocity/(10/difficultyModifier);
 }else{currentBallVelocityY-=paddleVelocity/(10/difficultyModifier);
 }
   }
  }
  
  void score(){
      if (ballX + ballRadius > width){
  score2 += 1;
  setup();
  }
  if(ballX - ballRadius < 0){
  score1 += 1;
  setup();
  }
  textSize(50);
  text(nf(score2), width/7, height/10);
  text(nf(score1), width - width/7, height/10);
    if ((victoryScore != 0) && ((score1 == victoryScore) || (score2 == victoryScore))){
      ballRadius = 0;
      paddleWidth = 0;
    if (score2 == victoryScore){
    textSize(30);
    text("Player1 has won! the game will be restarting shortly", 150, height/2-100);
endGame = true;
    }else{textSize(30);
    text("Player2 has won! the game will be restarting shortly", 150, height/2-100);
endGame = true;
};
    
    }
  }
  void gameEnd(){
    if (endGame){
  delay(5000);
  startGame = false;
  endGame = false;
  score1 = 0;
  score2 = 0;
  }
  }
