// original → https://vrchat.com/home/launch?worldId=wrld_6325c346-2ea9-4bc5-8d65-59cd7e700d06
// it is not my idea.

const float BPM = 151.0;

vec3 pcg3df(vec3 v)
{
  uvec3 r = floatBitsToUint(v);
  r = r * 1664525u + 1013904223u;

  r.x += r.y*r.z;
  r.y += r.z*r.x;
  r.z += r.x*r.y;

  r ^= r >> 16u;

  r.x += r.y*r.z;
  r.y += r.z*r.x;
  r.z += r.x*r.y;

  return vec3(r) / float(0xffffffffu);
}

mat2 rot(float r)
{
   return mat2(cos(r), -sin(r), sin(r), cos(r));
}

vec2 pmod(vec2 p, float r)
{
  float a = atan(p.x, p.y) + acos(-1.0) / r;
  float n = acos(-1.0) * 2.0 / r;
  a = floor(a/n)*n;
  return p * rot(-a);
}

float sdBox(vec3 p, vec3 d)
{
  vec3 q = abs(p) - d;
  return length(max(q, 0.0)) + min(max(q.x, max(q.y, q.z)), 0.0);
}

float sdRoom(vec3 p)
{
  float d = sdBox(p, vec3(1.7, 2.0, 0.5));
  float d2 = sdBox(p, vec3(1.6, 1.9, 0.51));

  return max(d, -d2);
}

float sdTable(vec3 p)
{
  float d = sdBox(p + vec3(0.0, 1.2, 0.0), vec3(0.25, 0.02, 0.5));
  float d2 = sdBox(p + vec3(0.0, 1.6, 0.0), vec3(0.025, 0.4, 0.025));

  return min(d, d2);
}

float sdPlate(vec3 p)
{
  p.y += 1.1;
  p.x += 0.15;
  float d = max(length(p) - 0.1, -(length(p + vec3(0.0, -0.125, 0.0)) - 0.2));

  p.x -= 0.3;

  float d2 = max(length(p) - 0.1, -(length(p + vec3(0.0, -0.125, 0.0)) - 0.2));


  return min(d, d2);
}

float sdChair(vec3 p)
{
  float d = sdBox(p, vec3(0.2, 0.025, 0.2));
  float d2 = sdBox(p + vec3(0.15, 0.0, 0.15), vec3(0.02, 0.5, 0.02));
  float d3 = sdBox(p + vec3(-0.15, 0.0, 0.15), vec3(0.02, 0.5, 0.02));
  float d4 = sdBox(p + vec3(-0.15, 0.2, -0.15), vec3(0.02, 0.2, 0.02));
  float d5 = sdBox(p + vec3(0.15, 0.2, -0.15), vec3(0.02, 0.2, 0.02));
  float d6 = sdBox(p + vec3(0.0, -0.5, 0.15), vec3(0.2, 0.05, 0.05));

  return min(min(min(min(min(d, d2), d3), d4), d5), d6);
}

float sdChairs(vec3 p)
{
  p.xz *= rot(acos(-1.0)/2.0);
  float d = sdChair(p + vec3(0.0, 1.5, 0.5));

  p.xz *= rot(acos(-1.0));
  float d2 = sdChair(p + vec3(0.0, 1.5, 0.5));

  return min(d, d2);
}

struct Result
{
  float d;
  vec3 ld;
  float la;
  int id;
};

Result map(vec3 p)
{
  float i = floor(p.z) - 0.5;
  vec3 rnd = pcg3df(vec3(i, floor(iTime*BPM/60.0), 0.0));
  rnd.x -= 0.5;
  rnd.y -= 0.5;
  rnd.y *= 0.5;

  p.z = mod(p.z, 1.0) - 0.5;

  float room = sdRoom(p);
  float table = sdTable(p);
  float plate = sdPlate(p);
  float chairs = sdChairs(p);

  Result result;
  result.d = min(min(min(room, table), plate), chairs) * 0.5;
  result.ld = normalize(vec3(rnd.xy - vec2(sin(2.0 * iTime + rnd.z * acos(-1.0)) * 0.5, 0.0), 0.0) - p);
  result.la = 1.0 / pow(length(vec3(rnd.xy - vec2(sin(2.0 * iTime + rnd.z * acos(-1.0)) * 0.5, 0.0), 0.0) - p), 15.0);
  result.id = 0;

  float light = length(p + vec3(-rnd.xy + vec2(sin(2.0 * iTime + rnd.z * acos(-1.0)) * 0.5, 0.0), 0.0)) - 0.1;

  if (light < result.d)
  {
    result.d = light * 0.45;
    result.id = 1;
  }

  return result;
}

vec3 getNormal(vec3 p)
{
  return normalize(vec3(
    map(p + vec3(0.0001, 0.0, 0.0)).d - map(p + vec3(-0.0001, 0.0, 0.0)).d,
    map(p + vec3(0.0, 0.0001, 0.0)).d - map(p + vec3(0.0, -0.0001, 0.0)).d,
    map(p + vec3(0.0, 0.0, 0.0001)).d - map(p + vec3(0.0, 0.0, -0.0001)).d
  ));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 p = (gl_FragCoord.xy * 2.0 - iResolution.xy) / min(iResolution.x, iResolution.y);

  float time = iTime*BPM/60.0;

  p.x = mod(floor(time), 8.0) < 1.0 ? abs(p.x) : p.x;
  p = 3.0 < mod(floor(time), 8.0) && mod(floor(time), 8.0) < 5.0 ? pmod(p, 4.0) : p;

  vec3 ro = vec3(sin(time / 8.0) * 1.5, sin(time / 5.0) * 3.0 - 0.25, 1.0-time);
  vec3 ta = vec3(sin(time / 8.0) * 1.5, sin(time / 5.0) * 3.0 - 0.25, -time);
  vec3 cDir = normalize(ta - ro);
  vec3 cUp = normalize(cross(vec3(1.0, 0.0, 0.0), cDir));
  vec3 cSide = normalize(cross(cDir, cUp));

  float fov = mod(floor(time), 4.0) < 1.0 ? 1.0 : 0.6;
  vec3 rd = normalize(p.x * cSide + p.y * cUp + cDir * fov);

  float t, d;
  float e;
  vec3 col = vec3(0.0);

  for (int i = 0; i < 256; i++)
  {
    vec3 rp = ro + rd * t;

    rp.x += sin(rp.z / 8.0) * 1.5;
    rp.y += sin(rp.z / 5.0) * 3.0;
    rp.xy *= rot(t * 0.15 * sin(time/3.0));

    Result result = map(rp);
    d = result.d;

    if (abs(d) < 0.0001)
    {
      vec3 n = getNormal(rp);
      col = vec3(clamp(pow(dot(n, result.ld), 20.0), 0.0, 1.0)) * result.la;
      break;
    }

    if (result.id == 1) e += 0.03/abs(d);
    t += d;
  }

  col *= exp(-t * 0.4);

  col = pow(col, vec3(0.4545));

  col += e * 0.01;

  col = pow(col, mod(floor(time), 16.0) < 8.0 ? vec3(0.7, 0.8, 0.95) : vec3(0.9, 1.0, 0.75));

  float noise = pcg3df(vec3(p, iTime)).x;
  col += vec3(noise) * 0.105;

  float v = 1.0 - clamp(pow(0.525 * length(p), 10.0), 0.0, 1.0);

  col *= v;
  fragColor = vec4(col, 1.0);
}
