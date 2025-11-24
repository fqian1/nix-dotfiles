#ifdef GL_ES
precision highp float;
#else
precision highp float;
#endif

// -------------------------------
// 1) Global Constants
// -------------------------------
const int   MAX_STEPS       = 200;    // RM max steps
const float MAX_DIST        = 100.0;  // RM max distance
const float MIN_DIST        = 0.0010; // RM min distance
const float LINE_THICKNESS  = 0.005;  // Thickness of the wireframe lines
const float cubeSize = 1.5;           // Size of cubes
const float SPACING         = 5.0;    // Distance between cube centers
const float aberrationOffset = 0.025; // CA offset
const float startRadius= 0.125;       // CA start radius
const float endRadius = 1.0;          // CA end radius
const float distortionStrength = 0.1; // Lens distorsion strength
const int   AA = 1;                   // AA samples
const float fallOff = 0.09;           // Light control
mat3 R;

// -------------------------------
// 2) Rotation Matrices
// -------------------------------
mat3 rotateX(float angle)
{
    float c = cos(angle);
    float s = sin(angle);
    return mat3(
        1.0,  0.0,  0.0,
        0.0,    c,   s,
        0.0,   -s,   c
    );
}

mat3 rotateY(float angle)
{
    float c = cos(angle);
    float s = sin(angle);
    return mat3(
         c,  0.0, -s,
         0.0, 1.0,  0.0,
         s,  0.0,   c
    );
}

mat3 rotateZ(float angle)
{
    float c = cos(angle);
    float s = sin(angle);
    return mat3(
          c,   s,  0.0,
         -s,   c,  0.0,
        0.0, 0.0, 1.0
    );
}

// -------------------------------
// 3) Distance to a 3D Line Segment
// -------------------------------
/*
float distToSegment(vec3 p, vec3 A, vec3 B)
{
    vec3 pa = p - A;
    vec3 ba = B - A;
    float t = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
    vec3 closest = A + ba * t;
    return length(p - closest);
} */

// -------------------------------
// 4) SDF for a Single Wireframe Cube
// -------------------------------

float sdfWireCube(vec3 p) // highly optimized (waldeck)
{
    vec3 a = vec3(0.5*cubeSize);
    vec3 q = abs(p);
    vec3 r = q - a;
    vec3 s = step(q, a);
    r *= r;
    s *= r;
    return sqrt(dot(r,vec3(1.0)) - max(max(s.x,s.y),s.z)) - LINE_THICKNESS;
}

// -------------------------------
// 5) Scene SDF with Infinite Repetition and Rotation
// -------------------------------
float mapScene(vec3 p)
{
    // Rotate the point
    vec3 rotatedP = R * p;

    // Apply infinite repetition using mod
    vec3 grid = vec3(SPACING);
    vec3 p_mod = mod(rotatedP + grid * 0.5, grid) - grid * 0.5;

    // Compute distance to the wireframe cube at the repeated position
    float d = sdfWireCube(p_mod);

    return d;
}

// -------------------------------
// 6) Raymarch Function
// -------------------------------
float raymarch(vec3 ro, vec3 rd, out vec3 hitPos)
{
    float t = 0.0;
    for(int i = 0; i < MAX_STEPS; i++)
    {
        vec3 p = ro + rd * t;
        float d = mapScene(p);

        if(d < MIN_DIST)
        {
            hitPos = p;
            return t; // Hit detected
        }

        // Dynamic step size
        t += d * 0.9; // Multiplier less than 1 to prevent overshooting

        if(t > MAX_DIST)
            break;
    }

    hitPos = ro + rd * t;
    return t; // No hit
}

// -------------------------------
// 7) Normal Calculation (Optional for Shading)
// -------------------------------
vec3 getNormal(vec3 p)
{
    float e = 0.001;
    float d = mapScene(p);

    float dx = mapScene(p + vec3(e, 0.0, 0.0)) - d;
    float dy = mapScene(p + vec3(0.0, e, 0.0)) - d;
    float dz = mapScene(p + vec3(0.0, 0.0, e)) - d;

    return normalize(vec3(dx, dy, dz));
}

// -------------------------------
// 8) Lens Distortion Function
// -------------------------------
vec2 lensDistortion(vec2 uv, float k)
{
    // Distance from the center
    float r = length(uv);

    // Apply barrel distortion
    float theta = atan(uv.y, uv.x);
    float rd = r * (1.0 + k * pow(r, 2.0));

    // Reconstruct distorted coordinates
    vec2 distortedUV = rd * vec2(cos(theta), sin(theta));
    return distortedUV;
}

// -------------------------------
// 9) Chromatic Aberration Function (Enhanced with Radial Scaling)
// -------------------------------
vec3 chromaticAberration(vec2 uv, float baseOffset)
{
    // Calculate the radial distance from the center
    float r = length(uv);

    // Maximum possible radius with uv normalized to [-1, 1]
    float maxRadius = sqrt(2.0);

    // Define at what normalized radius the aberration starts and ends
    // float startRadius = 0.125; // Starts increasing at 50% of max radius
    // float endRadius = 1.0;   // Fully applies at max radius

    // Calculate the scaling factor using smoothstep for smooth transition
    float factor = smoothstep(startRadius, endRadius, r / maxRadius);

    // Adjust the base offset based on the scaling factor
    float offset = baseOffset * factor;

    // Define offsets for each color channel based on the adjusted offset
    vec2 offsetR = vec2(offset, 0.0);  // Red shifted right
    vec2 offsetB = vec2(-offset, 0.0); // Blue shifted left

    // Shifted UV coordinates for red and blue channels
    vec2 uvR = uv + offsetR;
    vec2 uvB = uv + offsetB;

    // Ray directions for each channel
    vec3 rdR = normalize(vec3(uvR.x, uvR.y, -1.0));
    vec3 rdG = normalize(vec3(uv.x, uv.y, -1.0));
    vec3 rdB = normalize(vec3(uvB.x, uvB.y, -1.0));

    // Ray origin
    vec3 ro = vec3(0.0, 0.0, 20.0);

    // Raymarching for Red Channel
    vec3 hitPosR;
    float tR = raymarch(ro, rdR, hitPosR);
    vec3 colorR = vec3(0.0);
    if(tR < MAX_DIST)
    {
        float fadeR = exp(-fallOff * tR);
        vec3 N = getNormal(hitPosR);
        vec3 lightDir = normalize(vec3(1.0, 1.0, 1.0));
        // float diffuse = max(dot(N, lightDir), 0.0);
        colorR = vec3(1.0) * fadeR;
    }

    // Raymarching for Green Channel
    vec3 hitPosG;
    float tG = raymarch(ro, rdG, hitPosG);
    vec3 colorG = vec3(0.0);
    if(tG < MAX_DIST)
    {
        float fadeG = exp(-fallOff * tG);
        vec3 N = getNormal(hitPosG);
        vec3 lightDir = normalize(vec3(1.0, 1.0, 1.0));
        // float diffuse = max(dot(N, lightDir), 0.0);
        colorG = vec3(1.0) * fadeG;
    }

    // Raymarching for Blue Channel
    vec3 hitPosB;
    float tB = raymarch(ro, rdB, hitPosB);
    vec3 colorB = vec3(0.0);
    if(tB < MAX_DIST)
    {
        float fadeB = exp(-fallOff * tB);
        vec3 N = getNormal(hitPosB);
        vec3 lightDir = normalize(vec3(1.0, 1.0, 1.0));
        // float diffuse = max(dot(N, lightDir), 0.0);
        colorB = vec3(1.0) * fadeB;
    }

    // Combine the color channels
    return vec3(colorR.r, colorG.g, colorB.b);
}

// -------------------------------
// A) Compute Camera Basis Vectors
// -------------------------------
vec3 computeCameraForward(vec3 pos, vec3 target)
{
    return normalize(target - pos);
}

vec3 computeCameraRight(vec3 forward, vec3 up)
{
    return normalize(cross(forward, up));
}

vec3 computeCameraUp(vec3 right, vec3 forward)
{
    return cross(right, forward);
}

// -------------------------------
// 10) Main Image Function with Lens Distortion and Chromatic Aberration
// -------------------------------
void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec3 accumulatedColor = vec3(0.0);

    // Apply rotation based on mouse input
    // Convert mouse coordinates to rotation angles (radians)
    float angleZ = (iMouse.x / iResolution.x-0.5) * 3.14159;  // Rotate around Y-axis
    float angleX = (iMouse.y / iResolution.y) * 3.14159;  // Rotate around X-axis

    // Create rotation matrices with negative angles for inverse rotation
    mat3 Rx = rotateX(angleX);   // Negative for inverse rotation
    mat3 Rz = rotateZ(-angleZ);  // Negative for inverse rotation
    R  = Rz * Rx;                // Combined rotation

    for(int y = 0; y < AA; y++)
    {
        for(int x = 0; x < AA; x++)
        {
            // Jitter UV coordinates within the pixel
            vec2 jitter = vec2(float(x), float(y)) / float(AA);
            vec2 uv = (fragCoord + jitter - 0.5 * iResolution.xy) / iResolution.y;

            // Apply lens distortion
            uv = lensDistortion(uv, distortionStrength);

            // Apply chromatic aberration
            vec3 color = chromaticAberration(uv, aberrationOffset);

            accumulatedColor += color;
        }
    }

    // Average the accumulated color
    accumulatedColor /= float(AA * AA);;

    fragColor = vec4(accumulatedColor, 1.0);
}
