//
//  Common.h
//  ShaderPreview
//
//  Created by Caroline on 8/8/2023.
//

#ifndef Common_h
#define Common_h

#import <simd/simd.h>

struct LightingParams {
  vector_float3 lightDirection;
  vector_float4 newColor;
};

#endif /* Common_h */
