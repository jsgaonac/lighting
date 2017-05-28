/**
 * Ray Tracer
 * by Juan Sebastian Gaona C.
 * 
 */

import remixlab.proscene.*;
import remixlab.dandelion.geom.Vec;

Scene scene;
PGraphics canvas;
String renderer = P3D;
PShader lightShader;

void setup() {
  size(800, 600, renderer);
  canvas = createGraphics(width, height, renderer);
  scene = new Scene(this, (PGraphics3D) canvas);
  scene.setAxesVisualHint(true);
  scene.setGridVisualHint(false);
  scene.showAll();

  lightShader = loadShader("shaders/LightFrag.glsl", "shaders/LightVert.glsl");
}

void draw() {
  scene.beginDraw();
  canvas.background(0);
  doDrawing();
  scene.endDraw();
  scene.display();
}

void doDrawing() {
  drawLight();
  drawGround();  
  drawGeometry();
  canvas.shader(lightShader);
}

void drawLight() {
  int r = 255;
  int g = 255;
  int b = 255;

  float x = 100;
  float y = 100;
  float z = 100;
  canvas.ambientLight(r, g, b, x, y, z);
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