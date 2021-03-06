#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif



////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Pre Curl Scaler Direction Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef SF2D

// Paramaters
float2 FN_direction : FN_DIRECTION = float2(1.0, 0.0);
	
float FN_ (float2 p)
{
	return preCurlDirection(p, FN_direction);
}

#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

