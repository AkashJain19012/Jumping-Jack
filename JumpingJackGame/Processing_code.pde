
    /*THIS IS PING PONG*/
import processing.serial.*;
Serial myPort;
String myText="";

int n;
int startTimeMs;
// The time until the game starts, in milliseconds
// (easy to convert to seconds, sec = ms/1000)
final int startDelayMs = 5000;
boolean atStartup = true;
 
int gameWidth = 500;
int gameHeight = 400;
int x = 250;
int y = 100;
//int x_speed = 5;
int y_speed = 2;
// Variables to keep track of paddle
int  x_paddle = 250, y_paddle = 389;
int paddle_width_half = 40;
// score keeping
int score = 0;
int speed=2;
int d=0;
int extra=0;
int life=0;
int i=0;
int j=0;
int intVal;

 
void setup(){
  
  // Current time, in milliseconds
  startTimeMs = millis();
  size(500, 400);
  rectMode(CENTER);
  frameRate(60);
  myPort=new Serial(this,"COM4",9600);
      myPort.bufferUntil('\n');
}
 
void serialEvent(Serial myPort)
{
  myText=myPort.readStringUntil('\n');
  n = Integer.parseInt(myText.trim());
 println(n);
}



void draw(){
  // If we're in the startup time window, show a countdown
  if (atStartup) {
    // The current time, in milliseconds
        int curTimeMs = millis();
    // The remaining time in the startup period
        int startupTimeRemainingMs = startDelayMs - (curTimeMs - startTimeMs);
        startScreen(startupTimeRemainingMs);
        atStartup = startupTimeRemainingMs > 0;
    // Short-circuit if we're still in the startup phase.
    return;
  }
  background(240);
  fill(0);
  textAlign(CENTER,CENTER);
  text("GO!", gameWidth/2, gameHeight/2);
  
  y = y + y_speed;
  if (y<0)
    y_speed = -y_speed;
 /* if (x>width || x<0)  
  //  x_speed = -x_speed;*/

  // Check if keys are pressed
  if (keyPressed) {
   
    
    if (key == ' ') {
      // Restart
      x = 250;
      y = 100;
      x_paddle = 250;
      score=0;
      speed=5;
      d=0;
    life=0;
    extra=0;
    
      
    }
   
  }
   if( n<10 && y>0 &&y<400)
    { y=y-3;}
  // Check if paddle is at edge of screen 
  if (x_paddle>width) x_paddle = width;
  if (x_paddle<0) x_paddle = 0;

  // Check if ball collides with paddle
  if ((x_paddle)<x && (x_paddle+paddle_width_half)>x && 
    (y_paddle-5)<y && (y_paddle)>y)
       {
    // ball is hitting paddle rectangle, reverse y_speed
    y_speed = -y_speed;
    score = score + 1;
  }
  
  // Clear screen to black
  background(0);
  // Set fill color to white
  fill(255);
  // Draw a circle at position x,y, 10 pixels large
  ellipse(x, y, 10, 10);
  // draw paddle
  rect(x_paddle, y_paddle, paddle_width_half*2+1, 10);
  x_paddle=x_paddle+speed;
  if(x_paddle>500||x_paddle<0)
  {
      speed=-1*speed;
  
  
  }
  if(d==10 && score==5)
  {  speed = abs(speed)+2;
      
      d=d+1;
  }
 if(d==1 && score==15)
  {  speed = abs(speed)+2;
      
      d=d+1;
  }
  if(d==2 && score==25)
  {  speed = abs(speed)+2;
      
      d=d+1;
  }
 
 
  
  
  
  if(score==5&&extra==0)
  {
     life=life+1;
    extra=extra+1;
  }   
  if(score==7&&extra==1)
  {
      life=life+1;
      extra=extra+1;
      
  }
  if(score==9&&extra==2)
  {
      life=life+1;
      extra=extra+1;
      
  }

  
  if(y>height&&life>0)
  {
    x = 250;
    y = 100;
    life=life-1;
  } 
  
  

      
  // Display score
  textSize(16);
  textAlign(RIGHT);
  text("Score", 40, 390);
  textAlign(LEFT);
  text(score, 70,390);
  textSize(16);
  textAlign(RIGHT);
  text("Life",30,20);
  textAlign(LEFT);
  text(life, 70, 20);
  text(myText.length(),120,120);
  
  
  if(y>height&&life==0)
  { 
  
    textSize(40);
    textAlign(CENTER);
    text("Game over", 250, 150);
    textSize(30);
    text("Press SpaceBar to Restart", 250, 200);
    }
}
 




void startScreen(int remainingTimeMs){
  background(23);
  textSize(20);
  fill(230);
  textAlign(CENTER,CENTER);
  // Show the remaining time, in seconds;
  // show n when there are n or fewer seconds remaining.
  text("JUMPING JACK GAME",gameWidth/2,gameHeight/2-40);
  text("GAME STARTS IN ",gameWidth/2,gameHeight/2-10);
  textSize(60);
  fill(230);
  text(ceil(remainingTimeMs/1000.0), gameWidth/2, 300);
}
