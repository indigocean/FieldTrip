
#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif



////////////////////////////////////////////////////////////////////////////////////////////////
// vector field function placeholder
#ifndef VF3D
#define VF3D placeHolderV3
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



uint threadCount;
StructuredBuffer<float3> bPos <string uiname="Seed Position 3D Buffer";>;
RWStructuredBuffer<float3> Output : BACKBUFFER;
float stepSize = 0.01666;
float maxDist <string uiname="Maximum Distance from Seed Position";> = 5;
float reset;

//GROUPSIZE
[numthreads(64, 1, 1)]
void CS_SimpleAgent( uint3 dtid : SV_DispatchThreadID )
{
	if (dtid.x >= threadCount) { return; }

	if (reset || maxDist < distance(Output[dtid.x], bPos[dtid.x])) 
	{ Output[dtid.x] = bPos[dtid.x]; }
	
	#if (INTEGRATIONMODE==1) 
	calcRK2V3(VF3D, Output[dtid.x], stepSize);
	#elif (INTEGRATIONMODE==2) 
	calcRK4V3(VF3D, Output[dtid.x], stepSize);
	#else 
	calcEulerV3(VF3D, Output[dtid.x], stepSize);
	#endif
}


technique11 SimpleAgent
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_SimpleAgent() ) );
	}
}

