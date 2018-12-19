String imagePath = "../halftone/gas.bmp";

PImage img;
IntDict charMap = new IntDict();
PFont f;
int multiplier = 20;
int blocksize = 10;
void settings() {
  img = loadImage(imagePath);
  size(img.width * multiplier, img.width * multiplier, P2D);
  noLoop();
}
void setup() {
  f = createFont("Arial", 16, true);
  textFont(f);
  img.loadPixels(); 
}
class PixelsArray {
  int[] p;
  PixelsArray(PImage image) {
    image.loadPixels(); 
    this.p = image.pixels;
  }
  int averageColor() {
    int length = this.p.length;
    color r = 0, g = 0, b = 0;
    for (int currentPixel : this.p) {
      r += red(currentPixel);
      g += green(currentPixel);
      b += blue(currentPixel);
    }
    return color(r / length, g / length, b / length);
  }
}
void draw() {
  int xblocks = floor(img.width / blocksize);
  int yblocks = floor(img.height / blocksize);
  System.out.println(xblocks * yblocks);
  for (int x = 0; x < xblocks; x++) {
    for (int y = 0; y < yblocks; y++) {
      System.out.println("" + x * xblocks + " " + y * yblocks);
      PixelsArray block = new PixelsArray(get(x, y, blocksize, blocksize));
      fill(block.averageColor());
      text("A", x * multiplier, y * multiplier);
      // Image Processing would go here
      // If we were to change the RGB values, we would do it here, 
      // before setting the pixel in the display window.
      
      // Set the display pixel to the image pixel
      // pixels[loc] = color(r, g, b);
    }
  }
  save("foobar.png");
  // updatePixels();
  // image(img, 0, 0);
}
