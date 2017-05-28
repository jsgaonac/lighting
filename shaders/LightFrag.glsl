#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertColor;
varying vec3 vecNormal;
varying vec3 lightDir;

uniform vec3 lightAmbient[8];

void main()
{
  // Ambient 
  float intensityVal = 0.1f;
  vec3 ambient = lightAmbient[0] * intensityVal; 

  // Diffuse
  vec3 direction = normalize(lightDir);
  vec3 normal = normalize(vecNormal);
  float diff = max(0, dot(direction, normal));
  vec3 diffuse = diff * lightAmbient[0];

  vec3 result = (ambient + diffuse) * vertColor.xyz;
  gl_FragColor = vec4(result, 1);
}