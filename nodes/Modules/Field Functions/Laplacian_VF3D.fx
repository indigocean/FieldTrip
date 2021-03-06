#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Laplacian Vector from a 3D Vector Field Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef VF3D

// Input Function placeholder
#ifndef FN_INPUT
#define FN_INPUT placeHolderV3
#endif

// Paramaters
float FN_eps : FN_EPS = 0.01;

float3 FN_ (float3 p)
{
	return calcLapV3(FN_INPUT, p, FN_eps);
	
}
#define VF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

