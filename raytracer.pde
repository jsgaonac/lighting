/**
 * Ray Tracer
 * by Juan Sebastian Gaona C.
 * 
 */

import remixlab.proscene.*;

Scene scene;
PGraphics canvas;
String renderer = P3D;
PShader lightShader;

void setup() {
  size(800, 600, renderer);
  canvas = createGraphics(width, height, renderer);
  scene = new Scene(this, (PGraphics3D) canvas);
  scene.setAxesVisualHint(false);
  scene.setGridVisualHint(false);
  scene.showAll();

  lightShader = loadShader("shaders/LightFrag.glsl", "shaders/LightVert.glsl");
}

void draw() {
  scene.beginDraw();
  canvas.background(0);
  canvas.shader(lightShader);
  canvas.directionalLight(255, 255, 255, 1, 1, -1);
  doDrawing();
  scene.endDraw();
  scene.display();
}

void doDrawing() {
  drawGround();  
  drawGeometry();
}

void drawGeometry() {
  canvas.noStroke();
  canvas.pushMatrix();
  canvas.translate(0, 0, 30);
  canvas.fill(255, 0, 0);
  canvas.sphere(30);
  canvas.translate(20, 100, 50);
  canvas.fill(0, 255, 0);
  canvas.sphere(50);
  canvas.translate(-50, -100, 20);
  canvas.fill(0, 0, 255);
  canvas.sphere(20);
  canvas.translate(35, -80, -10);
  canvas.fill(255, 0, 255);
  canvas.sphere(60);
  canvas.popMatrix();
}

void drawGround() {
  float size = width / 2;
  scene.setRadius(size);

  canvas.pushMatrix();
  canvas.rectMode(CENTER);
  canvas.fill(255);
  canvas.rect(0, 0, size, size);
  canvas.popMatrix();
}