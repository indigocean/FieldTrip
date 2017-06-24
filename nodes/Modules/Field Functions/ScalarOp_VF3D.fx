#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Vector Field with Scalar Field/Defualt Operand Basic Ops Functions + - * /
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef VF3D

// DEFINES
#ifndef FN_OP
#define FN_OP +
#endif

// Paramaters
float FN_Default : FN_DEFAULT;
float FN_reverseOrder : FN_REVERSEORDER;

// Input function placeholder
#ifndef FN_INPUT1
#define FN_INPUT1 placeHolderV3
#endif

// Input 2 Defualt option
#ifndef FN_INPUT2
float FN_singleValue (float3 p)
{
	return FN_Default; // if a second input class is not provided defualt to semantic
}
#define FN_INPUT2 FN_singleValue
#endif

float3 FN_ (float3 p)
{
	#if(FN_REVERSE==1) 
	return FN_INPUT2(p) FN_OP FN_INPUT1(p);
	#else
	return FN_INPUT1(p) FN_OP FN_INPUT2(p); 
	#endif
}

#define VF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}
