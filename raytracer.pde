/**
 * Basic Use.
 * by Jean Pierre Charalambos.
 * 
 * This example illustrates a direct approach to use proscene by Scene proper
 * instantiation.
 * 
 * Press 'h' to display the key shortcuts and mouse bindings in the console.
 */

import remixlab.proscene.*;

Scene scene;
PGraphics canvas;
String renderer = P3D;
PImage checkersImg;

void setup() {
  size(800, 600, renderer);
  canvas = createGraphics(width, height / 2, renderer);
  scene = new Scene(this, (PGraphics3D) canvas);
  scene.setAxesVisualHint(false);
  scene.setGridVisualHint(false);
  scene.showAll();

  loadAssets();
}

void loadAssets() {
  checkersImg = loadImage("assets/texture_checkers.png");
}

void draw() {
  scene.beginDraw();
  canvas.background(0);
  doDrawing();
  scene.endDraw();
  scene.display();
}

void doDrawing() {
  drawGround();  
}

void drawGround() {
  final float size = width / 4;
  canvas.pushMatrix();
  scene.setRadius(size);
  //canvas.textureWrap(REPEAT);
  canvas.beginShape();
  canvas.texture(checkersImg);
  canvas.vertex(-size, -size, 0, 0);
  canvas.vertex(size, -size, checkersImg.width, 0);
  canvas.vertex(size, size, checkersImg.width, checkersImg.height);
  canvas.vertex(-size, size, 0, checkersImg.height);
  canvas.endShape();
  canvas.popMatrix();
}