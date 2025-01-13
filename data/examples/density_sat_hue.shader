// Density-Saturation-Hue Shader for OBS Shaderfilter
// Modified by CameraTim for use with obs-shaderfilter 12/2024 v.12

uniform string notes<
    string widget_type = "info";
> = "Density adjustment shader: Density reduces luminance, while saturation is subtractively increased to avoid greyish colors.";

uniform float density_r <
    string label = "Red Density";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float saturation_r <
    string label = "Red Sat";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float hueRange_r <
    string label = "Red Hue Range";
    string widget_type = "slider";
    float minimum = 20.0;
    float maximum = 100.0;
    float step = 1.0;
> = 60.0;

uniform float hueShift_r <
    string label = "Red Hue Shift";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float density_y <
    string label = "Yellow Density";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float saturation_y <
    string label = "Yellow Sat";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float hueRange_y <
    string label = "Yellow Hue Range";
    string widget_type = "slider";
    float minimum = 20.0;
    float maximum = 100.0;
    float step = 1.0;
> = 60.0;

uniform float hueShift_y <
    string label = "Yellow Hue Shift";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float density_g <
    string label = "Green Density";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float saturation_g <
    string label = "Green Sat";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float hueRange_g <
    string label = "Green Hue Range";
    string widget_type = "slider";
    float minimum = 20.0;
    float maximum = 100.0;
    float step = 1.0;
> = 60.0;

uniform float hueShift_g <
    string label = "Green Hue Shift";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float density_c <
    string label = "Cyan Density";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float saturation_c <
    string label = "Cyan Sat";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float hueRange_c <
    string label = "Cyan Hue Range";
    string widget_type = "slider";
    float minimum = 20.0;
    float maximum = 100.0;
    float step = 1.0;
> = 60.0;

uniform float hueShift_c <
    string label = "Cyan Hue Shift";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float density_b <
    string label = "Blue Density";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float saturation_b <
    string label = "Blue Sat";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float hueRange_b <
    string label = "Blue Hue Range";
    string widget_type = "slider";
    float minimum = 20.0;
    float maximum = 100.0;
    float step = 1.0;
> = 60.0;

uniform float hueShift_b <
    string label = "Blue Hue Shift";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float density_m <
    string label = "Magenta Density";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float saturation_m <
    string label = "Magenta Sat";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float hueRange_m <
    string label = "Magenta Hue Range";
    string widget_type = "slider";
    float minimum = 20.0;
    float maximum = 100.0;
    float step = 1.0;
> = 60.0;

uniform float hueShift_m <
    string label = "Magenta Hue Shift";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float global_density < 
    string label = "Global Density";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float global_saturation < 
    string label = "Global Sat";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

float smoothGradation(float hue, float center, float range) {
    float diff = abs(hue - center);
    if (diff > 180.0) diff = 360.0 - diff;
    float halfRange = range / 2.0;
    return exp(-0.5 * pow(diff / halfRange, 2.0));
}

// Hue Range Influence
float changeHueRange(float hue, float center, float range) {
    return smoothGradation(hue, center, range);
}

// HSV Conversion Functions
float3 rgb2hsv(float3 c) {
    float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    float4 p = lerp(float4(c.bg, K.wz), float4(c.gb, K.xy), step(c.b, c.g));
    float4 q = lerp(float4(p.xyw, c.r), float4(c.r, p.yzx), step(p.x, c.r));
    
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return float3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

float3 hsv2rgb(float3 c) {
    float4 K = float4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    float3 p = abs(frac(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * lerp(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

// Adjust Density and Saturation in HSV
float3 addDenAndSat(float3 color, float density, float saturation, float weight) {
    // Convert to HSV to access saturation
    float3 hsv = rgb2hsv(color);
    float saturationFactor = hsv.y; // Use saturation as a scaling factor for density

    // Adjust luminance in RGB
    float luminance = dot(color, float3(0.299, 0.587, 0.114));
    float adjustedDensity = density * weight * saturationFactor;
    luminance = max(0.0, luminance - adjustedDensity);

    // Adjust saturation
    hsv.y = clamp(hsv.y + (saturation * weight), 0.0, 1.0);
    float3 adjustedColor = hsv2rgb(hsv);

    // Combine adjusted luminance with the color
    float3 finalColor = adjustedColor - dot(adjustedColor, float3(0.299, 0.587, 0.114)) + luminance;
    return clamp(finalColor, 0.0, 1.0);
}

float3 addHueShift(float3 color, float hueShift, float weight, float3 baseColor, float3 nextColor, float3 prevColor) {
    // Determine the direction of the hue shift
    if (hueShift > 0.0) {
        // Shift towards the next color (clockwise on the hue wheel)
        return lerp(color, nextColor, hueShift * weight);
    } else if (hueShift < 0.0) {
        // Shift towards the previous color (counterclockwise on the hue wheel)
        return lerp(color, prevColor, abs(hueShift) * weight);
    }
    return color;
}

float3 applyAdjustments(float3 color) {
    // Convert to HSV for hue calculation
    float3 hsv = rgb2hsv(color);
    float hue = hsv.x * 360.0; // Convert normalized hue [0,1] to degrees [0,360]

    // Define center hues and neighboring colors for each vector
    float3 red = float3(1.0, 0.0, 0.0);
    float3 green = float3(0.0, 1.0, 0.0);
    float3 blue = float3(0.0, 0.0, 1.0);
    float3 yellow = float3(1.0, 1.0, 0.0);
    float3 cyan = float3(0.0, 1.0, 1.0);
    float3 magenta = float3(1.0, 0.0, 1.0);

    // Calculate influence weights based on Hue Range
    float redWeight = changeHueRange(hue, 0.0, hueRange_r);
    float greenWeight = changeHueRange(hue, 120.0, hueRange_g);
    float blueWeight = changeHueRange(hue, 240.0, hueRange_b);
    float yellowWeight = changeHueRange(hue, 60.0, hueRange_y);
    float cyanWeight = changeHueRange(hue, 180.0, hueRange_c);
    float magentaWeight = changeHueRange(hue, 300.0, hueRange_m);

    // Normalize weights
    float totalWeight = redWeight + greenWeight + blueWeight + yellowWeight + cyanWeight + magentaWeight;
    if (totalWeight > 0.0) {
        redWeight /= totalWeight;
        greenWeight /= totalWeight;
        blueWeight /= totalWeight;
        yellowWeight /= totalWeight;
        cyanWeight /= totalWeight;
        magentaWeight /= totalWeight;
    }

    // Apply Density and Saturation
    color = addDenAndSat(color, density_r + global_density, saturation_r + global_saturation, redWeight);
    color = addDenAndSat(color, density_g + global_density, saturation_g + global_saturation, greenWeight);
    color = addDenAndSat(color, density_b + global_density, saturation_b + global_saturation, blueWeight);
    color = addDenAndSat(color, density_y + global_density, saturation_y + global_saturation, yellowWeight);
    color = addDenAndSat(color, density_c + global_density, saturation_c + global_saturation, cyanWeight);
    color = addDenAndSat(color, density_m + global_density, saturation_m + global_saturation, magentaWeight);

    // Apply Hue Shifts
    color = addHueShift(color, hueShift_r, redWeight, red, yellow, magenta);     // Red shifts to Yellow or Magenta
    color = addHueShift(color, hueShift_g, greenWeight, green, cyan, yellow);    // Green shifts to Cyan or Yellow
    color = addHueShift(color, hueShift_b, blueWeight, blue, magenta, cyan);     // Blue shifts to Magenta or Cyan
    color = addHueShift(color, hueShift_y, yellowWeight, yellow, red, green);    // Yellow shifts to Red or Green
    color = addHueShift(color, hueShift_c, cyanWeight, cyan, green, blue);       // Cyan shifts to Green or Blue
    color = addHueShift(color, hueShift_m, magentaWeight, magenta, blue, red);   // Magenta shifts to Blue or Red

    return clamp(color, 0.0, 1.0);
}

float4 mainImage(VertData v_in) : TARGET {
    float4 inputColor = image.Sample(textureSampler, v_in.uv);
    float3 vectorAdjustedColor = applyAdjustments(inputColor.rgb);
    return float4(vectorAdjustedColor, inputColor.a);
}
