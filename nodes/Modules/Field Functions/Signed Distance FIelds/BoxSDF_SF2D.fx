
#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Circle Distance Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

#ifndef SF2D
// Paramaters
StructuredBuffer<float2> FN_pos : FN_POS;
StructuredBuffer<float2> FN_size : FN_SIZE;

int FN_count : FN_COUNT;

float FN_ (float2 p)
{
	float d = 999999;
	for(int i = 0; i< FN_count; i++)
	{
		d = min (d, fBox(p-FN_pos[i], FN_size[i]));
	}
	return d;
}


#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

