#define AO
//#define SHADOW
//#define SSS


#ifndef SF3D
#define SF3D length // Just a place holder
#endif

#ifndef RAYMARCH_FXH
#include<packs\happy.fxh\raymarch.fxh>
#endif

#ifndef WRITEDEPTH
#define WRITEDEPTH 1
#endif


cbuffer cbControls:register(b0)
{
	float4x4 tVP:VIEWPROJECTION;
	float4x4 tV:VIEW;
};


Texture2D matCapTex <string uiname="MatCap Texture";> ;

SamplerState sMatCap <bool visible=false;>
{
	Filter=MIN_MAG_MIP_LINEAR;
	AddressU=CLAMP;
	AddressV=CLAMP;
};
////////////////////////////////////////////////////////////////
float4 matCap(float3 vn)
{
	vn.y = -vn.y;
	return float4(matCapTex.Sample(sMatCap, vn.xy *.5+.5));
}

////////////////////////////////////////////////////////////////
float4 matCapGrad(float3 vn, float3 gx, float3 gy)
{
	vn.y = -vn.y;
	vn.xy = vn.xy * .5 + .5;
	return matCapTex.SampleGrad(sMatCap, vn, gx, gy);
}


struct VS_IN{float4 PosO:POSITION;float4 TexCd:TEXCOORD0;};
struct VS_OUT{float4 PosWVP:SV_POSITION;float4 TexCd:TEXCOORD0;};
VS_OUT VS(VS_IN In){VS_OUT Out=(VS_OUT)0;Out.TexCd=In.TexCd;Out.PosWVP=float4(In.PosO.xy,0,1);return Out;}

struct PS_OUT
{
	float4 Color:SV_TARGET;
	#if WRITEDEPTH == 1
	float Depth:SV_DEPTH;
	#endif
};


PS_OUT PS_Grad(VS_OUT In)
{
	// Raymarch 
	////////////////////////////////////////////////////////////////
	float3 ro, rd, p, n;   	// origin, direction, position, normal
	float z;				// depth
	int matID;				// matID (optional)
	float2 uv=In.TexCd.xy;
	rayMarch(uv, ro, rd, p, n, z);
	////////////////////////////////////////////////////////////////
	
	float4 c=1;
	float g = saturate(-dot(rd,n));

	#ifdef AO
	float ao = calcAO(p,n);
	c.rgb *= ao;
	#endif
	
	#ifdef SHADOW
	float shadow = calcShadow(p);
	c.rgb *= shadow;
	#endif
	
	PS_OUT Out;
	Out.Color=c;

	#if WRITEDEPTH == 1
	float4 PosWVP=mul(float4(p.xyz,1),tVP);
	Out.Depth=PosWVP.z/PosWVP.w;
	#endif
	
	return Out;
}

PS_OUT PS_MatCap(VS_OUT In)
{
	// Raymarch 
	////////////////////////////////////////////////////////////////
	float3 ro, rd, p, n;
	float z;
	int matID;
	float2 uv=In.TexCd.xy;
	rayMarch(uv, ro, rd, p, n, z);
	////////////////////////////////////////////////////////////////
	
	float3 ppdx, ppdy;
	calcPPD(uv, z, rd, n, ppdx, ppdy);
	
	float4 c=1;
	float3 vn = mul(float4(n, 0), tV).xyz;
	c = matCap(vn);
	c = matCapGrad(vn, ppdx, ppdy);
	#ifdef AO
	float ao = calcAO(p,n);
	c.rgb *= ao;
	#endif
	
	#ifdef SHADOW
	float shadow = calcShadow(p);
	c.rgb *= shadow;
	#endif
	
	float4 PosWVP=mul(float4(p.xyz,1),tVP);
	PS_OUT Out;
	Out.Color=c;
	Out.Depth=PosWVP.z/PosWVP.w;
	return Out;
}


technique11 RayMarchMatCap
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_5_0,VS()));
		SetPixelShader(CompileShader(ps_5_0,PS_MatCap()));
	}
}


