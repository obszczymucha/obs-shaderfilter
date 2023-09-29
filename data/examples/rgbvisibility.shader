// RGB visibility separation filter, created by EposVox

uniform float RedVisibility<
    string label = "Red Visibility";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 1.0;

uniform float GreenVisibility<
    string label = "Green Visibility";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 1.0;

uniform float BlueVisibility<
    string label = "Blue Visibility";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 1.0;

uniform string notes<
    string widget_type = "info";
> = "Modify Colors to correct for gamma, use equal values for general correction.";

float4 mainImage(VertData v_in) : TARGET
{
    float4 color = image.Sample(textureSampler, v_in.uv);
    float redChannel = pow(color.r, Red) * RedVisibility;
    float greenChannel = pow(color.g, Green) * GreenVisibility;
    float blueChannel = pow(color.b, Blue) * BlueVisibility;
    
    return float4(redChannel, greenChannel, blueChannel, 1);
}
