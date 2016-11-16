/*****************************************************************************
 *
 *  Pour le lancer, passer par Sketch et "Importer une librairie" avec "video", "sound" et "zxing"
 * 
 *****************************************************************************/

// IMPORT THE ZXING4PROCESSING LIBRARY AND DECLARE A ZXING4P OBJECT
import com.cage.zxing4p3.*;
ZXING4P zxing4p;
  
import processing.sound.*;
SoundFile file;

// PROCESSING VIDEO LIBRARY
import processing.video.*;
Capture video;

String decodedText;
String latestDecodedText = "";

int tw;


/*****************************************************************************
 *
 *  SETUP
 *
 *****************************************************************************/
void setup()
{
  size(640, 480);

  // LAYOUT
  textAlign(CENTER);
  textSize(30);

  // CREATE CAPTURE
  video = new Capture(this, width, height);

  // START CAPTURING
  video.start();  

  // CREATE A NEW EN-/DECODER INSTANCE
  zxing4p = new ZXING4P();

  // DISPLAY VERSION INFORMATION
  zxing4p.version();
} // setup()


/*****************************************************************************
 *
 *  DRAW
 *
 *****************************************************************************/
void draw()
{ 
  background(0);

  // UPDATE CAPTURE
  if (video.available()) video.read();

  // DISPLAY VIDEO CAPTURE
  set(0, 0, video);



  // TRY TO DETECT AND DECODE A QRCODE IN THE VIDEO CAPTURE
  // decodeImage(boolean tryHarder, PImage img)
  // tryHarder: false => fast detection (less accurate)
  //            true  => best detection (little slower)
  try
  {  
    decodedText = zxing4p.decodeImage(false, video);
  }
  catch (Exception e)
  {  
    println("Zxing4processing exception: "+e);
    decodedText = "";
  }
  if (!decodedText.equals(""))
  {
    if (decodedText.equals("http://fr.wikipedia.org/"))
    {
      file = new SoundFile(this, "mp3/b.mp3");
      file.play();
      latestDecodedText = decodedText;
      delay(5000);
      file.stop();
    }
    if (decodedText.equals("TURLUTUTU"))
    {
      file = new SoundFile(this, "mp3/a.mp3");
      file.play();
      latestDecodedText = decodedText;
      delay(5000);
      file.stop();
    }
  }
} // draw()