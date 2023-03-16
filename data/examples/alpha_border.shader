uniform float4 border_color;
uniform int border_thickness;
uniform float alpha_cut_off = 0.5;

float4 mainImage(VertData v_in) : TARGET
{
    float4 pix = image.Sample(textureSampler, v_in.uv);
    if (pix.a > alpha_cut_off)
        return pix;
    [loop] for(int x = -border_thickness;x<border_thickness;x++){
            [loop] for(int y = -border_thickness;y<border_thickness;y++){
                if(abs(x*x)+abs(y*y) < border_thickness*border_thickness){
                    float4 t = image.Sample(textureSampler, v_in.uv + float2(x*uv_pixel_interval.x,y*uv_pixel_interval.y));
                    if(t.a > alpha_cut_off)
                        return border_color;
                }
            }
    }
    return pix;
}