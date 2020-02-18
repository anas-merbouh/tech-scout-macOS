//
//  OPRCalculations.metal
//  Blueprint
//
//  Created by Anas Merbouh on 2020-02-09.
//  Copyright © 2020 Blueprint Technologies Inc. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

kernel void inverse_matrix()
{
    half4x4 alliance_matrix = half4x4({1,1,1,0},{1,0,1,1},{1,1,0,1},{0,1,1,1});
    determinant(alliance_matrix);
}
