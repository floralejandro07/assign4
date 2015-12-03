//You should implement your assign3 here.
final int GAME_START=1, GAME_READY=2, GAME_RUN=3, GAME_LOSE=4;
int gameState;
int num=5;
PImage background1,background2,
       ending1Img,ending2Img,
       starting1Img,starting2Img,
       enemyImg,jetImg,hpImg,treasureImg,
       elementGainbomb,electmentEnemy,
       shootImg;

int treasureX,treasureY,enemyX,enemyY,backgroundX,jetX,jetY;
float hp;

boolean  starting1=true;
boolean  starting2=false;
boolean  ending1=false;
boolean  ending2=false;
boolean  upPressed=false;
boolean  downPressed=false;
boolean  leftPressed=false;
boolean  rightPressed=false;


//enemy
int count=1;
boolean []enemy1 = new boolean[num];
boolean []enemy2 = new boolean[num];
boolean []enemy3 = new boolean[8];
float[]X1=new float [num];
float[]X2=new float [num];
float[]X3=new float [8];
float[]Y1=new float [num];
float[]Y2=new float [num];
float[]Y3=new float [8];

//flame
int counter;
int current;
float flameX=-100;
float flameY=-100;
PImage  [] flameImg =new PImage [num];
boolean [] flame= new boolean [num];


//bullet
int shoot=0;
int score;
boolean[]bullet=new boolean[num];
int []bulletX= new int [num];
int []bulletY= new int [num];





void setup () {
  size(640,480);
  
  gameState=GAME_START;
  
  background1=loadImage("img/bg1.png");
  background2=loadImage("img/bg2.png");
  enemyImg=loadImage("img/enemy.png");
  jetImg=loadImage("img/fighter.png");
  hpImg=loadImage("img/hp.png");
  treasureImg=loadImage("img/treasure.png");
  starting1Img=loadImage("img/start1.png");
  starting2Img=loadImage("img/start2.png");
  ending1Img=loadImage("img/end1.png");
  ending2Img=loadImage("img/end2.png");
  shootImg=loadImage("img/shoot.png");
  
  //flame
  for(int i=0;i<5;i++){
  flameImg[i]=loadImage("img/flame"+(i+1)+".png");
  }
  
  //treasure
  treasureX=floor(random(200,500));
  treasureY=floor(random(50,425));
  
  //enemy
  enemyX=-310;
  enemyY=floor(random(100,415));
  for(int i=0;i<5;i++){
  enemy1[i]=true;
  enemy2[i]=true;
  }
  for(int i=0;i<8;i++){
  enemy3[i]=true;
  }
  
  //jet
  jetX=589;
  jetY=215;
  
   //bullet
  for(int i=0;i<5;i++){
   bullet[i] = false;}
  
 
  
   
 
}

void draw() {
  
  switch(gameState){
   case GAME_START:
   
   if(starting1){
     image(starting2Img,0,0);
     }
     
   //hover
   if(mouseX>=200 && mouseX<=400 && mouseY>=370 && mouseY<=421){
     starting1=false;
     starting2=true;
     if(starting2){
     image(starting1Img,0,0);
       //click
       if(mousePressed){
       gameState= GAME_READY;
       } 
       else{ 
       starting1=true;} 
     }
   }
 
   break;
   
   
   case GAME_READY:
   
   image(background2,0,0);
   
   //replace jet,HP,bullet,enemy
   hp=44;   
   //flame
   counter = 0;
   current = 0;
   //jet
   jetX=580;
   jetY=215;
   //enemy
   for(int i=0;i<5;i++){
     enemy1[i]=true;
     enemy2[i]=true;    
     }
   for( int i=0;i<8; i++){
   enemy3[i]=true;}
   enemyX=-310;
   enemyY=floor(random(100,415));
   count=1;
   //bullet
   for(int i=0;i<5;i++){
   bullet[i]=false;  
   bulletY[i]=-1000;  
   bulletX[i]=-1000;}  
   shoot=0;
   score=0;
   
   gameState=GAME_RUN;
   
   break;
   
   
   case GAME_RUN:
   
   //BACKGROUNG move
   backgroundX=backgroundX%1282;
   backgroundX-=1;
   
   image(background2,backgroundX,0);
   image(background1,backgroundX+641,0);
   image(background2,backgroundX+1282,0);
   
                  
   //jet
   image(jetImg,jetX,jetY);
   
   //keyboard control
   if (upPressed){
   jetY-=4;
     if(jetY<=0){
      jetY=0;}
   }
   if (downPressed){
   jetY+=4;
     if(jetY>=429){
     jetY=429;}
   }
   if (leftPressed){
   jetX-=4;
     if(jetX<=0){
       jetX=0;}
   }
   if (rightPressed){
   jetX+=4;
     if(jetX>=589){
       jetX=589;}
   }
   
    //flame
      image(flameImg[current], flameX, flameY);      
      counter ++;
      if ( counter % 6 == 0){
        current ++;
      } 
      if ( current > 4){
        current = 0;
      }
      //flame buring
      if(counter >= 30){
        for (int i = 0; i < 5; i ++){
         flameX = 1000;
         flameY = 1000;
        }
      }   
      
  //bullet
   for(int i=0;i<5;i++){
      if(bullet[i]){       
      image(shootImg,bulletX[i],bulletY[i]);
       bulletX[i]-=6; //if  
      } 
      if(bulletX[i]<0){
      bullet[i]=false;
      }//if   
    }//for
    
    
   //bullet hit enemy
   for(int k = 0;k<5;k++){
   for(int i = 0;i<5;i++){
     if(enemy1[i]){
     if(bulletX[k] >= X1[i] - shootImg.width  && bulletX[k] <=  X1[i]  + enemyImg.width 
     && bulletY[k] >= Y1[i] - shootImg.height && bulletY[k] <=  Y1[i]  + enemyImg.height 
     && bullet[k] == true){
        bullet[k]=false;
        enemy1[i]=false;
        flameX=X1[i];
        flameY=Y1[i];
        X1[i]=-500;
        Y1[i]=-500;
        counter=0;
        score++;
       }//if
     }//if   
     
      if(enemy2[i]){
      if(bulletX[k] >= X2[i] - shootImg.width  && bulletX[k] <=  X2 [i]  + enemyImg.width 
      && bulletY[k] >= Y2[i] - shootImg.height && bulletY[k] <=  Y2 [i]  + enemyImg.height 
      && bullet[k] == true){
         bullet[k]=false;
         enemy2[i]=false;
         flameX=X2[i];
         flameY=Y2[i];
         X2[i]=-500;
         Y2[i]=-500;
         counter=0;
         score++;
        }//if
      }//if
   }//for i<5
   
   for(int i=0;i<8;i++){
     if(enemy3[i]){
     if(bulletX[k] >= X3[i] - shootImg.width  && bulletX[k] <= X3 [i]  + enemyImg.width 
     && bulletY[k] >= Y3[i] - shootImg.height && bulletY[k] <= Y3 [i]  + enemyImg.height 
     && bullet[k] == true){
        bullet[k]=false;         
        enemy3[i]=false;
        flameX=X3[i];
        flameY=Y3[i];
        X3[i]=-500;
        Y3[i]=-500;
        counter=0;
        score++;
        }//if
      }//if
     }//for i<8
   }//for k<5
   
   
     
   //HP    
   noStroke();
   fill(255,0,0);
   rect(6,3,hp,25);
   image(hpImg,0,0);
   
   
        
   //enemy  
   enemyX+=2;
   enemyX = enemyX % 641;
   
   if( count%3==1 ){
     for(int i=0;i<5;i++){ 
       if(enemy1[i]){
         image(enemyImg,enemyX+i*62,enemyY);
          X1[i] = enemyX+i*62;
          Y1[i] = enemyY;}
     }
     if(enemyX==-310){
       enemyY=floor(random(100,415));}
   }   
   
   if(count%3==2){    
    for(int i=0;i<5;i++){
      if(enemy2[i]){
      image(enemyImg,enemyX+i*62,enemyY-i*55);
      X2[i] = enemyX+i*62;
      Y2[i] = enemyY-i*55;}
    }
    if(enemyX==-310){
     enemyY=floor(random(245,415));}   
   }   
  
   if(count%3==0){
   for(int i=0;i<8;i++){
     if(enemy3[i]){
      float[]squareX={enemyX,enemyX+62,enemyX+2*62,enemyX+3*62,enemyX+4*62,enemyX+62,enemyX+2*62,enemyX+3*62};
      float[]squareY={enemyY,enemyY-55,enemyY-110,enemyY-55,enemyY,enemyY+55,enemyY+110,enemyY+55};
      image(enemyImg,squareX[i],squareY[i]);
      X3[i] =  squareX[i];
      Y3[i] =  squareY[i];}
     }   
   if(enemyX==-310){
    enemyY=floor(random(125,295));}
   }   
   
   if(enemyX==640){
     for(int i=0;i<5;i++){
     enemy1[i]=true;
     enemy2[i]=true;
     }//for
     for( int i=0;i<8; i++){
     enemy3[i]=true;}//for
     count++;     
     enemyX=-312;
   }//if
     
   
   //jet run into enemy
   for( int i = 0;i<5;i++){
     if(enemy1[i]){
       if( Y1[i]>=jetY-jetImg.height && Y1[i] <= jetY+jetImg.height 
        && X1[i]>=jetX-jetImg.height && X1[i] <= jetX+jetImg.height){
        enemy1[i]=false;
        X1[i]=-500;
        Y1[i]=-500;         
        hp-=39;     
        }    
      }
   
     if(enemy2[i]){
       if( Y2[i] >= jetY-jetImg.height && Y2[i] <= jetY+jetImg.height
        && X2[i] >= jetX-jetImg.height && X2[i] <= jetX+jetImg.height){
        enemy2[i]=false;
        X2[i]=-500;
        Y2[i]=-500;        
        hp-=39;
        }    
      }
   }
   
   for(int i=0;i<8;i++){
     if(enemy3[i]){
       if( Y3[i]>=jetY - jetImg.height && Y3[i] <= jetY+jetImg.height
        && X3[i]>=jetX - jetImg.height && X3[i] <= jetX+jetImg.height){
        enemy3[i]=false;
        X3[i]=-500;
        Y3[i]=-500;
        hp-=39;
        }
      }
   }
        
         
   //treasure
   image(treasureImg,treasureX,treasureY);
   //treasure replace
   if(jetY >= treasureY-35 && jetY <= treasureY+35){
     if(jetX <= treasureX+35 && jetX >= treasureX-41){
     treasureX = floor(random(150,500));
     treasureY = floor(random(50,425));
     hp+=19.5;}
   }
      
   
   //HP (maximium and minimum)  
   if(hp>201){
     hp=201;}  
   if(hp<=6){
     gameState=GAME_LOSE;}
     
   break;
   
   
   case GAME_LOSE:
   
   ending1=true;
   
   if(ending1){
   image(ending2Img,0,0);
   }
   //hover
   if(mouseX>=200 && mouseX<=420 && mouseY>=300 && mouseY<=340){
     ending1=false;
     ending2=true;
       if(ending2){
       image(ending1Img,0,0);
       //click
         if(mousePressed){
           gameState= GAME_READY;
        } else{ending1=true;} 
     }
   }
   
   break;
   
  }
}

void keyPressed(){
  if(key==CODED){
    switch(keyCode){
       case UP:
         upPressed=true;
       break;
       case DOWN:
         downPressed=true;
       break;
       case LEFT:
         leftPressed=true;
       break;
       case RIGHT:
         rightPressed=true;
       break;
          }
      }
  }           
      
void keyReleased(){
  if(key==CODED){
    switch(keyCode){
      case UP:
        upPressed=false;
      break;
      case DOWN:
        downPressed=false;
      break;
      case LEFT:
        leftPressed=false;
      break;
      case RIGHT:
        rightPressed=false;
      break;
          }
        }
        
    if ( keyCode == ' '){
    if (gameState == GAME_RUN){
      if (bullet[shoot] == false){
        bullet[shoot] = true;
        bulletX[shoot] = jetX - 10;
        bulletY[shoot] = jetY + 9;
        shoot ++;
      }   
      if ( shoot> 4 ) {
        shoot = 0;
      }
    }
  }
}   
