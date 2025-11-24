#define PI 3.1415

const float EPS = 1e-2;
float OFFSET = EPS * 5.0;

float TIME;

vec2 rotate2d(vec2 p, float angle) {
    return p * mat2(cos(angle), -sin(angle),
        sin(angle), cos(angle));
}


// Gem clock by keim
// https://www.shadertoy.com/view/MsXcWr
float dfBC( in vec3 p, float r) {
    float a = floor(atan(p.z, p.x) / (PI * .25) + .5) * PI * .25, c = cos(a), s = sin(a);
    vec3 q = vec3(c * p.x + s * p.z, p.y, abs(-c * p.z + s * p.x)) / r;
    float fcBezel = dot(q, vec3(.544639035, .8386705679, 0)) - .544639035;
    float fcUGird = dot(q, vec3(.636291199, .7609957358, .1265661887)) - .636291199;
    float fcLGird = dot(q, vec3(.675808237, -.7247156073, .1344266163)) - .675808237;
    float fcStar = dot(q, vec3(.332894535, .9328278154, .1378894313)) - .448447409;
    float fcPMain = dot(q, vec3(.656059029, -.7547095802, 0)) - .656059029;
    float fcTable = q.y - .2727511892;
    float fcCulet = -q.y - .8692867378 * .96;
    float fcGirdl = length(q.xz) - .975;
    return max(fcGirdl, max(fcCulet, max(fcTable, max(fcBezel, max(fcStar, max(fcUGird, max(fcPMain, fcLGird)))))));
}

float sdPlane(vec3 p) {
    return p.y + 1.;
}

float dGlass(vec3 p) {
    return dfBC(p, 1.);
}

float map(vec3 p) {
    float b = sdPlane(p);
    float c = dGlass(p);
    return min(b, c);
}

float box(vec2 st, float size) {
    size = 0.5 + size * 0.5;
    st = step(st, vec2(size)) * step(1.0 - st, vec2(size));
    return st.x * st.y;
}


vec2 intersect(vec3 ro, vec3 ray) {
    float t = 0.0;
    for (int i = 0; i < 100; i++) {
        float res = abs(map(ro + ray * t));
        if (res < 0.005) return vec2(t, res);
        t += res;
    }

    return vec2(-1.0);
}

vec3 normal(vec3 pos, float e) {
    vec3 eps = vec3(e, 0.0, 0.0);

    return normalize(vec3(
        map(pos + eps.xyy) - map(pos - eps.xyy),
        map(pos + eps.yxy) - map(pos - eps.yxy),
        map(pos + eps.yyx) - map(pos - eps.yyx)));
}

float edge(vec3 p, vec3 n) {
    vec3 offset = vec3(0.001, 0., 0.);
    float e = 0.008;

    float d = dot(n, normal(p + offset.xyy, e));
    d = min(d, dot(n, normal(p - offset.xyy, e)));
    d = min(d, dot(n, normal(p + offset.yxy, e)));
    d = min(d, dot(n, normal(p - offset.yxy, e)));
    d = min(d, dot(n, normal(p + offset.yyx, e)));
    d = min(d, dot(n, normal(p - offset.yyx, e)));

    return step(d, 0.99999);
}

mat3 createCamera(vec3 ro, vec3 ta, float cr) {
    vec3 cw = normalize(ta - ro);
    vec3 cp = vec3(sin(cr), cos(cr), 0.0);
    vec3 cu = normalize(cross(cw, cp));
    vec3 cv = normalize(cross(cu, cw));
    return mat3(cu, cv, cw);
}

float triangle(float t) {
    return 1.0 - 8.0 * abs(fract(t) - 0.5);
}



vec3 render(vec2 p) {
    float effect = 1.;
    if (effect == 2.) {
        return vec3(p * 0.5 + 0.5, 1.);
    }

    float t = TIME * 0.7;
    vec3 ro = vec3(cos(t) * 10., sin(t * 2.) + 4., sin(t) * 10.);
    vec3 ta = vec3(0);
    mat3 cm = createCamera(ro, ta, 0.);
    vec3 ray = cm * normalize(vec3(p, 10.0));

    vec3 fresnel = vec3(0);
    float edgeValue = 0.;
    int wireframe = int(effect);
    float tt = 0.;

    for (int i = 0; i < 10; i++) {
        vec2 res = intersect(ro, ray);
        tt += res.x;

        if (res.y < -0.5) {
            return vec3(0.1, 0.2, 0.4) * 7.;
        }

        vec3 pos = ro + ray * res.x;
        vec3 nor = normal(pos, 0.008);

        if (dGlass(pos) > 0.005) {
            if (wireframe == 1) {
                return mix(vec3(.13, .16, .16), vec3(1.), step(0.5, edgeValue));
            }

            vec3 col = vec3(0);
            col += fresnel;
            col += vec3(0.001, 0.002, 0.004) * tt * 10.;
            return col;
        }

        if (i == 0 && dot(-ray, nor) < 0.5) {
            float a = 1. - dot(-ray, nor) * 2.;
            fresnel = mix(fresnel, vec3(0., 0.8, 0.8), a);
        }
        edgeValue += edge(pos, nor);

        float eta = 1.1;

        bool into = dot(-ray, nor) > 0.0;
        nor = into ? nor : -nor;
        eta = into ? 1.0 / eta : eta;

        ro = pos - nor * OFFSET;

        if (wireframe == 1) {
            continue;
        }

        ray = refract(ray, nor, eta);

        if (ray == vec3(0.0)) {
            ro = pos + nor * OFFSET;
            ray = reflect(ray, nor);
        }
    }
}

vec3 aaRender(vec2 p) {
    vec3 col = vec3(0.0);
    const int num = 4;

    for (int i = 0; i < num; i++) {
        float fi = float(i + 1);
        col += render(p + vec2(step(fi, 2.001), mod(fi, 2.001)) * 0.0015);
    }

    return col / float(num);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = (fragCoord.xy * 2.0 - iResolution.xy) / min(iResolution.x, iResolution.y);

  TIME = mod(iTime, 4.8) + 2.3;
  vec3 color = aaRender(uv);
  fragColor = vec4(color, 1.0);
}

