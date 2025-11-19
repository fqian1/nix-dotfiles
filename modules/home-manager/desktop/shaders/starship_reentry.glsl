#define NUM_OCTAVES 5
#define MAIN_ITERATIONS 30.0 // Reduced from 50 for performance

// --- Faster 2D Hash Function (Replaces rand) ---
// From Inigo Quilez - much cheaper than using sin(dot(...))
float hash21(vec2 p) {
    p = fract(p * vec2(5.3983, 5.4427));
    p += dot(p.yx, p.xy + 21.5351);
    return fract(p.x * p.y * 95.4337);
}

// --- Noise (Uses the new fast hash) ---
float noise(vec2 p){
    vec2 ip = floor(p);
    vec2 u = fract(p);
    // 3.0-2.0*u is faster than 6*u^5 - 15*u^4 + 10*u^3
    u = u*u*(3.0-2.0*u);

    float a = hash21(ip);
    float b = hash21(ip + vec2(1.0, 0.0));
    float c = hash21(ip + vec2(0.0, 1.0));
    float d = hash21(ip + vec2(1.0, 1.0));

    // Uses the optimized 'mix' function for linear interpolation
    float k0 = mix(a, b, u.x);
    float k1 = mix(c, d, u.x);
    return mix(k0, k1, u.y);
}

// --- FBM (No major change, uses the faster noise) ---
float fbm(vec2 x) {
    float v = 0.0;
    float a = 0.5;
    const vec2 shift = vec2(100.0);
    const mat2 rot = mat2( 0.87758256, 0.47942554, -0.47942554, 0.87758256 ); // cos(.5), sin(.5)
    // Using a 'const' loop limit helps the compiler (though NUM_OCTAVES is defined)
    for (int i = 0; i < NUM_OCTAVES; ++i) {
        v += a * noise(x);
        x = rot * x * 2.0 + shift;
        a *= 0.5;
    }
    return v;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 shake = vec2(
        sin(iTime * 1.5) * 0.01,
        cos(iTime * 2.7) * 0.01
    );

    vec2 p = ((fragCoord.xy + shake * iResolution.xy) - iResolution.xy * 0.5) / iResolution.y *
             mat2(8.0, -6.0, 6.0, 8.0);

    vec4 o = vec4(0.0);

    float t = iTime;
    float basefbm = fbm(p + vec2(t * 7.0, 0.0));

    // cache once per pixel
    float f = 3.0 + basefbm;

    // --- Optimized Loop: Reduced iterations and fixed integer counter ---
    for (int i_int = 1; i_int <= int(MAIN_ITERATIONS); ++i_int)
    {
        float i = float(i_int);
        float ii = i * i;
        float ti = (t + p.x * 0.1) * 0.03;

        // This vector is pre-calculated from your constants, but the compiler should handle it.
        vec2 trig_c = vec2(11.0 * i, 9.0 * i);
        vec2 trig = vec2(cos(ii + ti + trig_c.x), sin(ii + ti + trig_c.y));

        vec2 v = p + trig * 5.0 +
                 vec2(sin(t * 4.0 + i) * 0.005, cos(t * 4.5 - i) * 0.005);

        // Cheaper "tail noise" (still relies on the faster noise function)
        float tail = noise(v + vec2(t, i)) * (1.0 - i * (1.0/MAIN_ITERATIONS)); // Use division for speed

        float lenv = length(max(v, vec2(v.x * f * 0.02, v.y)));

        // --- Cheaper approximation for the 'exp' term ---
        float power_term = exp(sin(ii + t));

        // REDUCED BLOOM: Decreased the overall contribution multiplier
        // Original: vec4 contrib = vec4(0.8, 0.9, 1.1, 1.0) * power_term / lenv;
        // New:      vec4 contrib = vec4(0.8, 0.9, 1.1, 1.0) * power_term / lenv * 0.2; // roughly 5x reduction
        vec4 contrib = vec4(0.8, 0.9, 1.1, 1.0) * power_term / lenv * 0.2;


        o += contrib * (1.0 + tail * 2.0) * (i / MAIN_ITERATIONS); // Use division for speed
    }

    // --- Cheaper Tonemapping / Output ---
    // Further adjust the overall intensity if needed, or modify the power function.
    // We already scaled down contributions, so a small final adjustment should be enough.
    o *= 0.1;
    o = o / (1.0 + o);
    o = pow(o, vec4(1.5));

    fragColor = o;
}
