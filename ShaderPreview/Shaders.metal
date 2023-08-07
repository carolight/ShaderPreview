//
//  Shaders.metal
//  ShaderPreview
//
//  Created by Caroline on 8/8/2023.
//

#include <metal_stdlib>
using namespace metal;

#import "Common.h"

constant half4 backgroundColor = half4(0.8, 0.8, 0.9, 1.0);

// position: fragment position in screen coordinates
// color: input color. eg the SwiftUI view has an image
// so `color` is the image color at that position

[[stitchable]] half4 lighting(
  float2 position,
  half4 color,
  half4 newColor,
  device const LightingParams *params,
  int size_in_bytes)
{
  // the input image is a normal map
  half3 normal = normalize(color.xyz * 2 - 1);
  half3 lightDirection = normalize(half3(params->lightDirection));

  float diffuseIntensity = saturate(dot(normal, lightDirection));
  diffuseIntensity = max(diffuseIntensity, 0.0);
  half3 diffuseColor = half3(params->newColor.xyz) * diffuseIntensity;

  float ambientIntensity = 0.2;
  half3 ambientColor = half3(0.7, 0.7, 0.7) * ambientIntensity;
  half4 finalColor = half4(diffuseColor, color.w) + half4(ambientColor, color.w);

  if (position.x > 300 && position.y > 300) {
    return newColor;
  }

  if (color.w < 0.1) {
    return backgroundColor;
  }
  return half4(finalColor);
}
