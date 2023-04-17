PImage image;

ArrayList<Pixel> dots;

int reveal_area = 150;

int dots_max_speed = 2;

void setup(){
  fullScreen();
  
  frameRate(120);
  
  dots = new ArrayList<Pixel>();
  
  image = loadImage("Display.png");
  
  image.loadPixels();
  
  for (int i = 0; i < image.pixels.length; i++){
    if (image.pixels[i] != color(255, 255, 255)){
      dots.add(new Pixel(i % 1920, floor(i / 1920f), new int[]{int(red(image.pixels[i])), int(green(image.pixels[i])), int(blue(image.pixels[i]))}));
    }
  }
}

void draw(){
  background(255);
  
  for (Pixel dot : dots){
    dot.update();
    dot.show();
  }
}
