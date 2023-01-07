// Heat Wave Simple, Version 0.03, for OBS Shaderfilter
// Copyright ©️ 2022 by SkeletonBow
// License: GNU General Public License, version 2
//
// Contact info:
//		Twitter: <https://twitter.com/skeletonbowtv>
//		Twitch: <https://twitch.tv/skeletonbowtv>
//
// Description:
//		Generate a crude pseudo heat wave displacement on an image source.
//
// Based on:  https://www.shadertoy.com/view/td3GRn by Dombass <https://www.shadertoy.com/user/Dombass>
//
// Changelog:
// 0.03 - Added Opacity control
// 0.02 - Added crude Rate, Strength, and Distortion controls
// 0.01	- Initial release

uniform float Rate = 5.0;
uniform float Strength = 1.0;
uniform float Distortion = 10.0;
uniform float Opacity = 100.00;

float4 mainImage( VertData v_in ) : TARGET
{
	float2 uv = v_in.uv;
	float distort = clamp(Distortion, 3.0, 20.0);

    // Time varying pixel color
    float jacked_time = Rate*elapsed_time;
    float2 scale = 0.5;
	float str = clamp(Strength, -25.0, 25.0) * 0.01;
   	
    uv += str * sin(scale*jacked_time + length( uv ) * distort);
	float4 color = image.Sample( textureSampler, uv);
	color.a *= saturate(Opacity*0.01);
    return color;
}
