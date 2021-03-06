#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Laplacian Scalar from a 3D Scalar Field Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef SF3D

// Input Function placeholder
#ifndef FN_INPUT
#define FN_INPUT placeHolderS3
#endif

// Paramaters
float FN_eps : FN_EPS = 0.01;

float FN_ (float3 p)
{
	return calcLapS3(FN_INPUT, p, FN_eps);
	
}
#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

