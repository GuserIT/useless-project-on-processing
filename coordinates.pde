// Diniyar Salihov

import controlP5.*;

ControlP5 cp5;
Slider2D locCordPlaceS2D, pointLocCordS2D;
Slider alphaCornerS, cornerArrowS, lenLineArrowS, lenArrowS;
Toggle gridShow;

int widthSidebar = 200; boolean sidebar = false;

int posPressX, posPressY;
int deltaX, deltaY;
int oldCenterPointX, oldCenterPointY;

int centerPointX = 500, centerPointY = 250, centerRadius = 8;
float scale = 30, minScale = 3, maxScale = 800;
boolean grid = true;

int posPointX = 3, posPointY = 2, pointRadius = 5, alpha = 30;
int cornerArrow = 40;
float lenArrow = 3, lenLineArrow = 0.5;
int posPointLocalX = 0, posPointLocalY = 0;


void setup() {
  windowTitle("Cord");
  size(1000, 600);
  cp5 = new ControlP5(this);
  cp5.setFont(createFont("Ubuntu", 15));
  locCordPlaceS2D = cp5.addSlider2D("locCordPlaceS2DValue")
    .setPosition(width-widthSidebar+(widthSidebar-120)/2, 35)
    .setLabel("")
    .setSize(120, 120)
    .setMinMax(-25, -25, 25, 25)
    .setValue(3, 2)
    .setColorBackground(color(255))
    .setColorForeground(color(140))
    .setColorActive(color(140))
    .setColorLabel(color(30))
    .hide()
    ;
    
  alphaCornerS = cp5.addSlider("alphaCornerSValue")
    .setLabel("")
    .setPosition(width-widthSidebar+(widthSidebar-120)/2, 185)
    .setRange(0, 360)
    .setSize(120, 30)
    .setValue(30)
    .setColorBackground(color(255))
    .setColorForeground(color(255))
    .setColorActive(color(30))
    .setColorValueLabel(color(140))
    .hide()
    ;
    
  pointLocCordS2D = cp5.addSlider2D("pointLocCordS2DValue")
    .setPosition(width-widthSidebar+(widthSidebar-120)/2, 245)
    .setLabel("")
    .setSize(120, 120)
    .setMinMax(-9, -9, 9, 9)
    .setValue(0, 0)
    .setColorBackground(color(255))
    .setColorForeground(color(140))
    .setColorActive(color(140))
    .setColorLabel(color(30))
    .hide()
    ;
    
  cornerArrowS = cp5.addSlider("cornerArrowSValue")
    .setLabel("")
    .setPosition(width-widthSidebar+(widthSidebar-120)/2, 405)
    .setRange(0, 360)
    .setSize(120, 30)
    .setValue(40)
    .setColorBackground(color(255))
    .setColorForeground(color(255))
    .setColorActive(color(30))
    .setColorValueLabel(color(140))
    .hide()
    ;
  
  lenLineArrowS = cp5.addSlider("lenLineArrowSValue")
    .setLabel("")
    .setPosition(width-widthSidebar+(widthSidebar-120)/2, 440)
    .setRange(0, 15)
    .setSize(120, 30)
    .setValue(0.5)
    .setColorBackground(color(255))
    .setColorForeground(color(255))
    .setColorActive(color(30))
    .setColorValueLabel(color(140))
    .hide()
    ;
    
  lenArrowS = cp5.addSlider("lenArrowSValue")
    .setLabel("")
    .setPosition(width-widthSidebar+(widthSidebar-120)/2, 475)
    .setRange(0, 32)
    .setSize(120, 30)
    .setValue(3)
    .setColorBackground(color(255))
    .setColorForeground(color(255))
    .setColorActive(color(30))
    .setColorValueLabel(color(140))
    .hide()
    ;
    
  gridShow = cp5.addToggle("toggleValue")
    .setLabel("")
    .setPosition(width-widthSidebar+(widthSidebar-120)/2, 535)
    .setSize(120, 30)
    .setValue(true)
    .setColorBackground(color(255))
    .setColorForeground(color(30))
    .setColorActive(color(30))
    .hide()
    ;
    
}

void draw() {
  clear();
  background(255);
  fill(0);
  noStroke();
  circle(centerPointX, centerPointY, centerRadius);
  circle(convertCordX(posPointX), convertCordY(posPointY), pointRadius);
  circle(convertCordX(posPointX) + (cos(radians(alpha)) * scale * posPointLocalX) + (scale * posPointLocalY * cos(radians(90 - alpha))),
        convertCordY(posPointY) - (sin(radians(alpha)) * scale * posPointLocalX) + (scale * posPointLocalY * sin(radians(90 - alpha))), pointRadius);
  stroke(0);
  line(convertCordX(posPointX) + (cos(radians(alpha)) * scale * lenArrow), convertCordY(posPointY) - (sin(radians(alpha)) * scale * lenArrow),
      convertCordX(posPointX) - (cos(radians(alpha)) * scale * lenArrow), convertCordY(posPointY) + (sin(radians(alpha)) * scale * lenArrow));
  line(convertCordX(posPointX) + (cos(radians(alpha+90)) * scale * lenArrow), convertCordY(posPointY) - (sin(radians(alpha+90)) * scale * lenArrow),
      convertCordX(posPointX) - (cos(radians(alpha+90)) * scale * lenArrow), convertCordY(posPointY) + (sin(radians(alpha+90)) * scale * lenArrow));
      
  line(convertCordX(posPointX) + (cos(radians(alpha)) * scale * lenArrow), convertCordY(posPointY) - (sin(radians(alpha)) * scale * lenArrow),
      convertCordX(posPointX) + (cos(radians(alpha)) * (scale * lenArrow - lenLineArrow * scale * cos(radians(cornerArrow/2)))) - cos(radians(90-alpha)) * sin(radians(cornerArrow/2)) * scale * lenLineArrow,
      convertCordY(posPointY) - (sin(radians(alpha)) * (scale * lenArrow - lenLineArrow * scale * cos(radians(cornerArrow/2)))) - sin(radians(90-alpha)) * sin(radians(cornerArrow/2)) * scale * lenLineArrow);
  line(convertCordX(posPointX) + (cos(radians(alpha)) * scale * lenArrow), convertCordY(posPointY) - (sin(radians(alpha)) * scale * lenArrow),
      convertCordX(posPointX) + (cos(radians(alpha)) * (scale * lenArrow - lenLineArrow * scale * cos(radians(cornerArrow/2)))) + cos(radians(90-alpha)) * sin(radians(cornerArrow/2)) * scale * lenLineArrow,
      convertCordY(posPointY) - (sin(radians(alpha)) * (scale * lenArrow - lenLineArrow * scale * cos(radians(cornerArrow/2)))) + sin(radians(90-alpha)) * sin(radians(cornerArrow/2)) * scale * lenLineArrow);
  //top arrow
  /*line(convertCordX(posPointX) + (cos(radians(alpha+90)) * scale * lenArrow), convertCordY(posPointY) - (sin(radians(alpha+90)) * scale * lenArrow),
      convertCordX(posPointX) + (cos(radians(alpha+90)) * (scale * lenArrow - lenLineArrow * cos(radians(cornerArrow/2)))) - cos(radians(180-alpha)) * sin(radians(cornerArrow/2)) * lenLineArrow,
      convertCordY(posPointY) - (sin(radians(alpha+90)) * (scale * lenArrow - lenLineArrow * cos(radians(cornerArrow/2)))) - sin(radians(180-alpha)) * sin(radians(cornerArrow/2)) * lenLineArrow);
  line(convertCordX(posPointX) + (cos(radians(alpha+90)) * scale * lenArrow), convertCordY(posPointY) - (sin(radians(alpha+90)) * scale * lenArrow),
  *///    convertCordX(posPointX) + (cos(radians(alpha+90)) * (scale * lenArrow - lenLineArrow * cos(radians(cornerArrow/2)))) + cos(radians(180-alpha)) * sin(radians(cornerArrow/2)) * lenLineArrow,
   //   convertCordY(posPointY) - (sin(radians(alpha+90)) * (scale * lenArrow - lenLineArrow * cos(radians(cornerArrow/2)))) + sin(radians(180-alpha)) * sin(radians(cornerArrow/2)) * lenLineArrow);
  line(convertCordX(posPointX) + (cos(radians(alpha-90)) * scale * lenArrow), convertCordY(posPointY) - (sin(radians(alpha-90)) * scale * lenArrow),
      convertCordX(posPointX) + (cos(radians(alpha-90)) * (scale * lenArrow - lenLineArrow * scale * cos(radians(cornerArrow/2)))) - cos(radians(-alpha)) * sin(radians(cornerArrow/2)) * lenLineArrow * scale,
      convertCordY(posPointY) - (sin(radians(alpha-90)) * (scale * lenArrow - lenLineArrow * scale * cos(radians(cornerArrow/2)))) - sin(radians(-alpha)) * sin(radians(cornerArrow/2)) * lenLineArrow * scale);
  line(convertCordX(posPointX) + (cos(radians(alpha-90)) * scale * lenArrow), convertCordY(posPointY) - (sin(radians(alpha-90)) * scale * lenArrow),
      convertCordX(posPointX) + (cos(radians(alpha-90)) * (scale * lenArrow - lenLineArrow * scale * cos(radians(cornerArrow/2)))) + cos(radians(-alpha)) * sin(radians(cornerArrow/2)) * lenLineArrow * scale,
      convertCordY(posPointY) - (sin(radians(alpha-90)) * (scale * lenArrow - lenLineArrow * scale * cos(radians(cornerArrow/2)))) + sin(radians(-alpha)) * sin(radians(cornerArrow/2)) * lenLineArrow * scale);
  if (!grid) {
    line(0, centerPointY, width, centerPointY);
    line(centerPointX, 0, centerPointX, height);
  }
  else {
    for (int i = 0; i <= (int)height/scale; i++)
      line(0, i * scale + (centerPointY % scale), width, i * scale + (centerPointY % scale));
    for (int j = 0; j <= (int)width/scale; j++)
      line(j * scale + (centerPointX % scale), 0, j * scale + (centerPointX % scale), height);
  }
  fill(140);
  noStroke();
  if (sidebar) {
    rect(width-widthSidebar, 0, width, height);
    fill(30);
    rect(width-widthSidebar-2, 0, 4, height);
    rect(width-widthSidebar-15, 45, 15, 45, 20, 0, 0, 20);
    fill(255);
    textSize(20);
    text("-", width-widthSidebar-12, 72);
  } else {
    fill(30);
    rect(width-4, 0, 4, height);
    rect(width-13, 45, 15, 45, 20, 0, 0, 20);
    fill(255);
    textSize(20);
    text("+", width-11, 72);
  }
  posPointX = (int)locCordPlaceS2D.getArrayValue()[0];
  posPointY = -(int)locCordPlaceS2D.getArrayValue()[1];
  posPointLocalX = (int)pointLocCordS2D.getArrayValue()[0];
  posPointLocalY = (int)pointLocCordS2D.getArrayValue()[1];
}

float convertCordX(int x) {
  return (centerPointX + scale * x);
}

float convertCordY(int y) {
  return (centerPointY + scale * -y);
}

void alphaCornerSValue(int a) {
  alpha = a;
}

void cornerArrowSValue(int a) {
  cornerArrow = a;
}

void lenLineArrowSValue(float a) {
  lenLineArrow = a;
}

void lenArrowSValue(float a) {
  lenArrow = a;
}

void toggleValue(boolean flag) {
  grid = flag;
}

void mousePressed() {
  posPressX = mouseX;
  posPressY = mouseY;
  deltaX = 0; deltaY = 0;
  oldCenterPointX = centerPointX;
  oldCenterPointY = centerPointY;
  if (sidebar && mouseX > width-widthSidebar-15 && mouseX < width-widthSidebar && mouseY > 45 && mouseY < 90) {
    sidebar = false;
    locCordPlaceS2D.hide();
    pointLocCordS2D.hide();
    alphaCornerS.hide();
    gridShow.hide();
    cornerArrowS.hide();
    lenLineArrowS.hide();
    lenArrowS.hide();
  } else if (!sidebar && mouseX > width-15 && mouseX < width && mouseY > 45 && mouseY < 90) {
    sidebar = true;
    locCordPlaceS2D.show();
    pointLocCordS2D.show();
    alphaCornerS.show();
    gridShow.show();
    cornerArrowS.show();
    lenLineArrowS.show();
    lenArrowS.show();
  }
}

void mouseDragged() {
  if ((posPressX < width - widthSidebar && sidebar) || !sidebar) {
    deltaX = mouseX - posPressX;
    deltaY = mouseY - posPressY;
    centerPointX = oldCenterPointX + deltaX;
    centerPointY = oldCenterPointY + deltaY;
  }
}

void mouseWheel(MouseEvent event) {
  if ((mouseX < width - widthSidebar && sidebar) || !sidebar) {
    float e = event.getCount();
    scale += scale * (-e)/10;
    if (scale < minScale) scale = minScale;
    if (scale > maxScale) scale = maxScale;
  }
}
