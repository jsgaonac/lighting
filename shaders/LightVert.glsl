uniform mat4 modelview;
uniform mat4 model;
uniform mat4 transform;
uniform mat3 normalMatrix;

uniform vec4 lightPosition;
uniform vec3 lightNormal;

attribute vec4 position;
attribute vec4 color;
attribute vec3 normal;

varying vec4 vertColor;
varying vec3 vecNormal;
varying vec3 lightDir;

void main()
{
  gl_Position = transform * position;

  vec3 vecPos = vec3(modelview * position);
  lightDir = normalize(lightPosition.xyz - vecPos);
  vecNormal = normalize(normalMatrix * normal);
  vertColor = color;    
}