#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Divergence Scalar from 2D Vector Field Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef SF2D

// Input class placeholder
#ifndef CL_INPUT
#define CL_INPUT placeHolderV2
#endif

// Paramaters
float FN_eps : FN_EPS = 0.01;

float FN_ (float2 p)
{
	return calcDivV2(CL_INPUT, p, FN_eps);
}

#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}
