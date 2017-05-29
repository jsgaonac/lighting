#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertColor;
varying vec3 vecNormal;
varying vec3 lightDir;

uniform vec3 lightColor;
uniform vec3 liAmbient;
uniform vec3 liDiffuse;
uniform vec3 liSpecular;

uniform vec3 ambientMaterial;
uniform vec3 diffuseMaterial;
uniform vec3 specularMaterial;

uniform float specularShininess;

void main()
{
  // Ambient 
  vec3 ambient = liAmbient * ambientMaterial; 

  // Diffuse
  vec3 direction = normalize(lightDir);
  vec3 normal = normalize(vecNormal);
  float diff = max(0, dot(direction, normal));
  vec3 diffuse = liDiffuse * (diff * diffuseMaterial);

  // Specular
  vec3 viewDir = normalize(-gl_FragCoord.xyz);
  vec3 reflectDir = reflect(-lightDir, normal);
  float spec = pow(max(0, dot(viewDir, reflectDir)), specularShininess * 128);
  vec3 specular = liSpecular * (spec * specularMaterial);

  vec3 result = (ambient + diffuse + specular) * vertColor.xyz;
  gl_FragColor = vec4(result, 1);
}