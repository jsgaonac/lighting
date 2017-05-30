/**
 * Lighting
 * by Juan Sebastian Gaona C.
 * 
 */

import remixlab.proscene.*;
import remixlab.dandelion.geom.Vec;

Scene scene;
PGraphics canvas;
String renderer = P3D;
PShader lightShader;

class Material {
  public Vec ambient;
  public Vec diffuse;
  public Vec specular;
  public float shininess;

  Material(Vec ambient, Vec diffuse, Vec specular, float shininess) {
    this.ambient = ambient;
    this.diffuse = diffuse;
    this.specular = specular;
    this.shininess = shininess;
  }
}

enum LightComponents {
  AMBIENT,
  DIFFUSE,
  SPECULAR
}

LightComponents currentComponent = LightComponents.AMBIENT;

// We define light as material but it isn't, it has ambient, diffuse and specular
// components though.
Material light = new Material(
  new Vec(.2f, .2f, .2f),
  new Vec(.5f, .5f, .5f),
  new Vec(1, 1, 1),
  0
);

// Materials components values taken from http://devernay.free.fr/cours/opengl/materials.html
Material[] materials = {
  new Material( // Gold
    new Vec(0.24725f, 0.1995f, 0.0745f),
    new Vec(0.75164f, 0.60648f, 0.22648f),
    new Vec(0.628281f, 0.555802f, 0.366065f),
    0.4f
  ),

  new Material( // Ruby
    new Vec(0.1745f, 0.01175f, 0.01175f),
    new Vec(0.61424f, 0.04136f, 0.04136f),
    new Vec(0.727811f, 0.626959f, 0.626959f),
    0.6f
  ),

  new Material( // Black rubber
    new Vec(0.02f, 0.02f, 0.02f),
    new Vec(0.01f, 0.01f, 0.01f),
    new Vec(0.4f, 0.4f, 0.4f),
    .078125f
  ),

  new Material( // Brass
    new Vec(.329412f, 0.223529f, 0.027451f),
    new Vec(.780392f, .568627f, .113725f),
    new Vec(.992157f, .941176f, .807843f),
    .21794872f
  ),

  new Material( // Obsidian
    new Vec(0.05375f, .05f, .06625f),
    new Vec(.18275f, .17f, .22525f),
    new Vec(.332741f, .328634f, .346435f),
    0.3f
  ),

  new Material( // Yellow plastic
    new Vec(0, 0, 0),
    new Vec(.5f, .5f, 0),
    new Vec(.6f, .6f, .5f),
    0.25f
  )
};

int currentMaterial = 0;

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
  doDrawing();
  scene.endDraw();
  scene.display();
}

void doDrawing() {
  drawLight();
  drawGround();  
  drawGeometry();
  doShaders();
}

void doShaders() {
  Vec ambientColor = materials[currentMaterial].ambient;
  Vec diffuseColor = materials[currentMaterial].diffuse;
  Vec specularColor = materials[currentMaterial].specular;

  float shininess = materials[currentMaterial].shininess;
  
  lightShader.set("liAmbient", light.ambient.x(), light.ambient.y(), light.ambient.z());
  lightShader.set("liDiffuse", light.diffuse.x(), light.diffuse.y(), light.diffuse.z());
  lightShader.set("liSpecular", light.specular.x(), light.specular.y(), light.specular.z());

  lightShader.set("ambientMaterial", ambientColor.x(), ambientColor.y(), ambientColor.z());
  lightShader.set("diffuseMaterial", diffuseColor.x(), diffuseColor.y(), diffuseColor.z());
  lightShader.set("specularMaterial", specularColor.x(), specularColor.y(), specularColor.z());
  lightShader.set("specularShininess", shininess);
  
  canvas.shader(lightShader);
}

void drawLight() {
  int r = 255;
  int g = 255;
  int b = 255;

  Vec cameraPos = scene.camera().position();

  float x = cameraPos.x();
  float y = cameraPos.y();
  float z = cameraPos.z();

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
  canvas.box(20);
  canvas.translate(35, -80, -10);
  canvas.fill(255, 0, 255);
  canvas.sphere(60);
  canvas.translate(100, 70, 0);
  canvas.fill(255, 255, 0);
  canvas.box(60);
  canvas.translate(-200, 20, -20);
  canvas.fill(255, 255, 255);
  canvas.sphere(50);
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

void keyPressed() {
  float delta = 0.05f;
  float dR = 0;
  float dG = 0;
  float dB = 0;

  switch (key) {
    case '4': dR = -delta; break;
    case '5': dR = delta; break;
    case '6': dG = -delta; break;
    case '7': dG = delta; break;
    case '8': dB = -delta; break;
    case '9': dB = delta; break;
    default: break;
  }

  switch (currentComponent) {
    case AMBIENT: light.ambient.add(dR, dG, dB); break;
    case DIFFUSE: light.diffuse.add(dR, dG, dB); break;
    case SPECULAR: light.specular.add(dR, dG, dB); break;
    default: break;
  }
}

void keyReleased() {
  switch (key) {
    case 'k': currentMaterial = (currentMaterial + 1) % materials.length; break;
    case 'j': currentMaterial = currentMaterial - 1 >= 0 ? currentMaterial - 1 : materials.length - 1;
    case '1': currentComponent = LightComponents.AMBIENT; break;
    case '2': currentComponent = LightComponents.DIFFUSE; break;
    case '3': currentComponent = LightComponents.SPECULAR; break;
    default: break;
  }
}