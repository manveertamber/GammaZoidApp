import android.media.MediaPlayer;
import android.content.res.AssetFileDescriptor;
import android.content.Context;
import android.app.Activity;
/*
import android.os.Looper;//for setup() if needed
import android.os.Bundle;
import android.view.Gravity;
import android.view.Window;
import android.widget.RelativeLayout;
import android.app.Activity;
//import com.google.ads.*;//un comment if you use other from ads
import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdView;
import com.google.android.gms.ads.AdSize;
import com.google.android.gms.ads.MobileAds;
*/

MediaPlayer mp;
Context context; 
Activity act;
AssetFileDescriptor afd;
PFont font,defaultfont;

int x,y;

int time;
int time2;

boolean up;

float circleposy,circleposx;
int circleposy1;

int randomr,randomg,randomb;
int actualr,actualg,actualb;
int randomrrect,randomgrect,randombrect;

boolean start = false;

float rectpos;
float gapstart;
float circlesize;

int upvalue;
int halfcircle;
int threehunnitscale;
int rectspeed;
int twohunnitscale;

PImage background,background2;

float scroll,scrollspeed;

boolean direction;

int score = 0;
int lastscore = 0;
int highscore = 0;
float obstacletype;
float obstacleheight;

boolean playsound = false;
PImage sound,nosound;
int imagesize;
int fourthimagesize;

boolean firstrun = true;
boolean died = false;

int halfx;
int halfy;

String characters = "dC3PmV7A^YMt!W.Z9c?*12NsDOIEj6K,0Rw5:TL vx$fyQSa&FGkhuH@lB4o;bgqrJ%U8p#zneXi";

PImage titletext,button,darkbutton,gameover,display,restart,darkrestart;

float overallspeed;
void settings(){
  fullScreen();
}
void setup(){
frameRate(35);
orientation(LANDSCAPE);
x = width;
y = height;
overallspeed = x/1280.0f;
if(overallspeed>=1.18){
overallspeed = 1.18;
}
else if(overallspeed<0.8){
overallspeed = 0.8;
}
halfx = x/2;
halfy = y/2;
score = 0;
 
 if(firstrun){ 
 startsong();
 loadscore();
 firstrun = false;
 try{
    button = loadImage("button.png");
    darkbutton = loadImage("darkbutton.png");
    titletext = loadImage("titletext.png");
    gameover = loadImage("gameover.png");
    display = loadImage("display.png");
    restart = loadImage("restart.png");
    darkrestart = loadImage("darkrestart.png");
    sound = loadImage("newsound1.png");
    nosound = loadImage("newsound.png");
    imagesize = round(0.065*x);
    fourthimagesize = imagesize/4;
    font = loadFont("BerlinSansFB-Reg-48.vlw");
    defaultfont = loadFont("LucidaSans-48.vlw");
 }
 catch(Exception e){
 
 }
 }
up = false;


scroll = x;
scrollspeed = round(768 * 0.003) * overallspeed;
try{
background = loadImage("background-1430105_960_720.png");
background.resize(x, y); //Resizes the image to be the size of the window
background2 = loadImage("background-1430105_960_7202.png");
background2.resize(x, y); //Resizes the image to be the size of the window
}
catch(Exception e){
  background(0);
}
circleposy = halfy;
circleposy1 = halfy;
circleposx = 0.14 * x;
rectpos = x+circleposx;
noStroke();
randomcolour();


randomrectcolour();

actualr = 0;
actualg = 0;
actualb = 0;
time = millis();

upvalue = round((0.0105 * y)  * overallspeed);
rectspeed = round((0.020 * x)  * overallspeed);
circlesize = round(0.04 * y);

halfcircle = round(circlesize/2.2);

threehunnitscale = round(0.17*y);



twohunnitscale = round(0.07*y);
direction = true;
obstacletype = (int)random(1,7);
if(obstacletype == 1 || obstacletype == 6){
gapstart = random(y-threehunnitscale,0+threehunnitscale);
}
if(obstacletype >=2&&obstacletype<=5){
  gapstart = random(0,halfy-threehunnitscale);
}
obstacleheight = random(0,(y-threehunnitscale)-(0+threehunnitscale));
 
}




void draw(){ 

  if(direction == false){
  scroll+=scrollspeed;
  }
  if(direction == true){
  scroll-=scrollspeed;
  }
   if(scroll>=x){
    direction = true;
    }
    if(scroll<0){
    direction = false;
    }
    
  if (start == false && died) {
    pushMatrix();
    translate(scroll,0);
    image(background,0,0);
    image(background2,0-x,0);
    image(background,0-(x*2),0);
    image(background2,0-(x * 3),0);
   
    popMatrix();
    imageMode(CENTER);
    image(gameover,halfx,y*0.2,x*0.6,(x*0.6)/7);
    image(display,halfx,halfy,x*0.35,(x*0.35)/1.6);
    fill(0);
    textAlign(CENTER);
    
    textFont(font, twohunnitscale);
    text("Score: " + lastscore,halfx,halfy - ((x*0.35)/1.6)/5);
    text("Highscore: " + highscore,halfx,y*0.6 - ((x*0.35)/1.6)/5);
    if(mousePressed && mouseX>halfx-(0.15*x) && mouseX<halfx+(0.15*x) && mouseY>(0.85*y)-((0.3 * x)/3.5)/2 && mouseY<(0.85*y)+((0.3 * x)/3.5)/2){
      
      image(darkrestart,halfx,0.85 * y, 0.3 * x,(0.3 * x)/3.5);
      delay(25);
      start = true;
       died = false;
      imageMode(CORNER);
    }
    else{
    image(restart,halfx,0.85 * y, 0.3 * x,(0.3 * x)/3.5);
    imageMode(CORNER);
    }
   
  }
  else if(start == false){
    pushMatrix();
    translate(scroll,0);
    image(background,0,0);
    image(background2,0-x,0);
    image(background,0-(x*2),0);
    image(background2,0-(x * 3),0);
    popMatrix();
    if(mousePressed && mouseX>halfx-(0.15*x) && mouseX<halfx+(0.15*x) && mouseY>(0.75*y)-((0.3 * x)/3.5)/2 && mouseY<(0.75*y)+((0.3 * x)/3.5)/2){
      imageMode(CENTER);
      image(darkbutton,halfx,0.75 * y, 0.3 * x,(0.3 * x)/3.5);
      delay(25);
      start = true;
      imageMode(CORNER);
    }
    else{
    imageMode(CENTER);
    image(titletext,halfx,0.2 * y,0.6 * x,(0.6*x)/4.8);
    image(button,halfx,0.75 * y, 0.3 * x,(0.3 * x)/3.5);
    imageMode(CORNER);
    }
  }
  else {
 
   
   pushMatrix();
   translate(scroll,0);
   image(background,0,0);
   image(background2,0-x,0);
   image(background,0-(x*2),0);
   image(background2,0-(x * 3),0);
   popMatrix();
   if(start == true){
      fill(255);
      
      textFont(defaultfont,twohunnitscale);
      textAlign(CENTER);
      text(score,halfx,y*0.1);
    }
  
  //change colour every 5 seconds
  if (millis() > time + 5000)
  {
  randomcolour();
  time = millis();
  }
  
  //controls shift of colour to random generated colour
  actualr = pushcolour(actualr,randomr);
  actualg = pushcolour(actualg,randomg);
  actualb = pushcolour(actualb,randomb);
  // if two have finshed transitioning then call random again
  if(actualr == randomr && actualg == randomg || actualr == randomr && actualb == randomb ||actualg == randomg  && actualb == randomb){
  randomcolour();
  }  
  //applies colour to circle
  fill(actualr,actualg,actualb);
  //depending on last pressed will go either up or down
  
  if(up == true){
  circleposy+=upvalue;
  circleposy1-=upvalue;
  }
  else{
  circleposy-=upvalue;
  circleposy1+=upvalue;
  }
  
  //makes circle
  ellipse(circleposx, circleposy1,circlesize,circlesize);
  ellipse(circleposx, circleposy,circlesize,circlesize);
  //moves circle to right
  
  

  
  //create the rectangle at x, 300 wide, obj, rects can be created off screen and brought in
  fill(randomrrect,randomgrect,randombrect);
  
 
  rectpos-=rectspeed;
  
   if(obstacletype >=2&&obstacletype<=5){
     if(rectpos == 0-threehunnitscale || rectpos<0-threehunnitscale){
    gapstart = random(0,halfy-threehunnitscale);
    rectpos = x+twohunnitscale;
    randomrectcolour();
    score++;
    obstacletype = (int)random(1,7);
  } 
  rect(rectpos,halfy,threehunnitscale,gapstart);
  rect(rectpos,halfy,threehunnitscale,-gapstart);
  rect(rectpos,halfy+gapstart+threehunnitscale,threehunnitscale,y);
  rect(rectpos,0,threehunnitscale,halfy-gapstart-threehunnitscale);
  
  if(rectpos<=circleposx && rectpos+threehunnitscale>circleposx){
  if(circleposy-halfcircle>halfy && circleposy -halfcircle<halfy+gapstart || circleposy1-halfcircle>halfy && circleposy1-halfcircle<halfy+gapstart || circleposy + halfcircle>halfy && circleposy + halfcircle<halfy+gapstart || circleposy1 + halfcircle>halfy && circleposy1 + halfcircle<halfy+gapstart){
    fill(255);
    textAlign(CENTER);
    textSize(twohunnitscale);
    died = true;
    start = false;
    lastscore = score;
    if(lastscore>highscore){
      highscore = lastscore;
      savescore();
    }
    setup();
    
  }
  else if(circleposy-halfcircle>0 && circleposy-halfcircle<halfy-gapstart-threehunnitscale || circleposy1-halfcircle>0 && circleposy1-halfcircle<halfy-gapstart-threehunnitscale || circleposy + halfcircle>0 && circleposy + halfcircle<halfy-gapstart-threehunnitscale || circleposy1 + halfcircle>0 && circleposy1 + halfcircle<halfy-gapstart-threehunnitscale){
    fill(255);
    textAlign(CENTER);
    textSize(twohunnitscale);
    died = true;
    start = false;
    lastscore = score;
    if(lastscore>highscore){
      highscore = lastscore;
      savescore();
    }
    setup();
    
      }
  }
    }
    else if(obstacletype == 6){
      if(rectpos<0-(threehunnitscale * 6)){
        randomrectcolour();
        obstacletype = (int)random(1,7);
        
      }
      float first = threehunnitscale * 0.7;
      int add = 0;
      while(first<halfy){
        first+=threehunnitscale*0.4;
        rect(rectpos + add,first,threehunnitscale,y-first-first);
        if(rectpos+add<circleposx + 0.5 * halfcircle && rectpos + add + threehunnitscale>circleposx - 0.5 *halfcircle){
        if(!(circleposy+halfcircle>0 && circleposy<first-halfcircle || circleposy1 - halfcircle>0 && circleposy1 + halfcircle<first)){
          fill(255);
          textAlign(CENTER);
          textSize(twohunnitscale);
     
          died = true;
          start = false;
          lastscore = score;
          if(lastscore>highscore){
            highscore = lastscore;
            savescore();
          }
          setup();
        }
        }
        add+=threehunnitscale;
      }
      
       
    }
    else if(obstacletype == 1){
      if(rectpos<0-(threehunnitscale * 6)){
        randomrectcolour();
        obstacletype = (int)random(1,7);
        
      }
      float first = halfy;
      int add = 0;
      while(first>threehunnitscale){
        first-=threehunnitscale*0.4;
        rect(rectpos + add,first,threehunnitscale,y-first-first);
        if(rectpos+add<circleposx + 0.5 * halfcircle && rectpos + add + threehunnitscale>circleposx - 0.5 *halfcircle){
        if(!(circleposy+halfcircle>0 && circleposy<first-halfcircle || circleposy1 - halfcircle>0 && circleposy1 + halfcircle<first)){
          fill(255);
          textAlign(CENTER);
          textSize(twohunnitscale);
   
          died = true;
          start = false;
          lastscore = score;
          if(lastscore>highscore){
            highscore = lastscore;
            savescore();
          }
          setup();
        }
        }
        add+=threehunnitscale;
      }
      
       
    }
      if(circleposy <=0 || circleposy >=y){
    fill(255);
    textAlign(CENTER);
    textSize(twohunnitscale);
   
 
    died = true;
    start = false;
    lastscore = score;
    if(lastscore>highscore){
      highscore = lastscore;
      savescore();
    }
    
    setup();
    
  }
  }
  if(playsound){
  image(sound,fourthimagesize,fourthimagesize,imagesize,imagesize);
  }
  else{
  image(nosound,fourthimagesize,fourthimagesize,imagesize,imagesize);
  }
}
void mousePressed(){
    if(mouseX>0 && mouseX<imagesize+fourthimagesize && mouseY>0 && mouseY<imagesize+fourthimagesize){
    if(playsound){
      playsound = false; 
      mp.pause();
    }
    else{
      playsound = true;
      mp.start();
      mp.setLooping(true); //restart playback end reached
    }
    }
   else{
   if (start == false) {
   
  }
  
    else {
      if(up){
      up = false;
      }
      else{
      up = true;
      }
}
   }
  }


void randomcolour(){
int random = (int)random(0,255);
int random2 = (int)random(0,255);
int random3 = (int)random(0,255);

randomr = (int)((random + (0.618033988749895f * 1) % 1) + 10)/2;
randomg = (int)((random2 + (0.618033988749895f * 2) % 1) + 10)/2;
randomb = (int)((random3 + (0.618033988749895f * 3) % 1) + 30)/2;

}

void randomrectcolour(){
int randomrect = (int)random(0,255);
int random2rect = (int)random(0,255);
int random3rect = (int)random(0,255);

randomrrect = (int)(randomrect + (0.618033988749895f * 1) % 1);
randomgrect = (int)(random2rect + (0.618033988749895f * 2) % 1);
randombrect = (int)(random3rect + (0.618033988749895f * 3) % 1);
}


int pushcolour(int og, int togo){
if(togo>og){
og+=1;
}
else if(togo<og){
og-=1;
}

else if(og == togo){

}
return og;
}

void startsong(){

  act = this.getActivity();
  context = act.getApplicationContext();
  try {
    mp = new MediaPlayer();
    afd = context.getAssets().openFd("Daydream Anatomy - 8-Bit Heroes - 02 8-Bit Bomber.mp3");//which is in the data folder
    mp.setDataSource(afd.getFileDescriptor());
    mp.prepare();
  } 
  catch(IOException e) {
    println("file did not load");
  }
  
}


 
 public void stop(){
   mp.pause();
   if (mp !=null){
   mp.release();
   mp = null;
   }
   
   }
   
   public void exit() {
   mp.pause();
     if (mp !=null){
   mp.release();
   mp = null;
   }
   
   }
   public void loadscore(){
     try {
      String[] scoreData = loadStrings("GammaZoid data.txt");
      String toconvert = scoreData[0];
      toconvert = decrypt(toconvert,characters);
      toconvert = removerandomchars(toconvert);
      highscore = Integer.parseInt(toconvert);
      
      }
     catch(NullPointerException e) {
        highscore = 0; 
      }
   }
   
   public void savescore(){
     String tosave = Integer.toString(highscore);
     tosave = addrandomchars(tosave,characters);
     tosave = encrypt(tosave,characters);
     String[] savedScore = {tosave};
     saveStrings("GammaZoid data.txt",savedScore);
   }
   public String addrandomchars(String workwith, String characterss){
     String toreturn = "";
     for(int count = 0;count<3;count++){
       int randomnum = (int)random(characterss.length());
       toreturn +=characterss.charAt(randomnum);  
     }
     toreturn +=workwith;
     for(int count = 0;count<3;count++){
       int randomnum = (int)random(characterss.length());
       toreturn +=characterss.charAt(randomnum);  
     }
   return toreturn;
   }
   
   public String removerandomchars(String workwith){
       return workwith.substring(3,workwith.length()-3);
   }
   
   public String encrypt(String workwith, String characterss){
    int counter = 0;
    String reversed = reverse(workwith);
    String encrypted = "";
    for(int count = 0; count<reversed.length();count++){
      char character = reversed.charAt(count);
      int index = characterss.indexOf(character);
      if(counter == 0){
      index += 9;
      counter++;
      }
      if(counter == 1){
      index += 5;
      counter--;
      }
      index+=(3 * count);
      if(index>characterss.length()-1){
        while(index>characterss.length()-1){
        index-=characterss.length();
        }
      }
      encrypted += characterss.charAt(index);
    }
    
    return encrypted;
  }
  
  public String decrypt(String workwith, String characterss){
    int counter1 = 0;
    String reversed = workwith;
    String decrypted = "";
    for(int count = 0;count<reversed.length();count++){
      char character = reversed.charAt(count);
      int index = characterss.indexOf(character);
      if(counter1 == 0){
        index -= 9;
        counter1++;
        }
        if(counter1 == 1){
        index -= 5;
        counter1--;
        }
        index-=(3 * count);
      if(index<0){
        while(index<0){
        index+=characterss.length();
        }
      }
      decrypted += characterss.charAt(index);
    }
    
    return reverse(decrypted);
  }
    
  public String reverse(String workwith){
    String reversed = "";
    for(int count = workwith.length()-1; count>=0; count--){
      reversed += workwith.charAt(count);
    }
    return reversed;
  }       
  /*
  @Override
public void onCreate(Bundle savedInstanceState) {
   super.onCreate(savedInstanceState);
Window window = getActivity().getWindow();
 RelativeLayout adsLayout = new RelativeLayout(this.getActivity());
 RelativeLayout.LayoutParams lp2 = new RelativeLayout.LayoutParams(
    RelativeLayout.LayoutParams.WRAP_CONTENT, RelativeLayout.LayoutParams.MATCH_PARENT);//Fill is deprecated
  
AdView adView = new AdView(this.getActivity());
adView.setAdSize(AdSize.BANNER);
adView.setAdUnitId("ca-app-pub-1170651226186353/3944341426");
  adsLayout.addView(adView);
    AdRequest newAdReq = new AdRequest.Builder()
 
    .build();
    
    adView.loadAd(newAdReq);
    window.addContentView(adsLayout,lp2);
 
 
};
*/