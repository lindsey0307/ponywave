// Compiled shader for PC, Mac & Linux Standalone

//////////////////////////////////////////////////////////////////////////
// 
// NOTE: This is *not* a valid shader file, the contents are provided just
// for information and for debugging purposes only.
// 
//////////////////////////////////////////////////////////////////////////
// Skipping shader variants that would not be included into build of current scene.

Shader "Hidden/Kino/Glitch/Analog" {
Properties {
 _MainTex ("-", 2D) = "" { }
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  //////////////////////////////////
  //                              //
  //      Compiled programs       //
  //                              //
  //////////////////////////////////
//////////////////////////////////////////////////////
No keywords set in this variant.
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "TexCoord"

Constant Buffer "VGlobals" (128 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_MatrixVP at 64
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD0.xy = input.TEXCOORD0.xy;
    return output;
}


-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0

Constant Buffer "FGlobals" (48 bytes) on slot 0 {
  Vector4 _Time at 0
  Vector2 _ScanLineJitter at 16
  Vector2 _VerticalJump at 24
  Float _HorizontalShake at 32
  Vector2 _ColorDrift at 40
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float4 _Time;
    float2 _ScanLineJitter;
    float2 _VerticalJump;
    float _HorizontalShake;
    float2 _ColorDrift;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<float, access::sample > _MainTex [[ texture (0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat2;
    bool u_xlatb2;
    float u_xlat4;
    u_xlat0.x = input.TEXCOORD0.y;
    u_xlat0.yz = FGlobals._Time.xx;
    u_xlat0.x = dot(u_xlat0.xy, float2(12.9898005, 78.2330017));
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 43758.5469;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 2.0, -1.0);
    u_xlatb2 = abs(u_xlat0.x)>=FGlobals._ScanLineJitter.xxxy.w;
    u_xlat2 = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat2 = u_xlat2 * FGlobals._ScanLineJitter.xxxy.z;
    u_xlat0.x = fma(u_xlat0.x, u_xlat2, input.TEXCOORD0.x);
    u_xlat0.w = 2.0;
    u_xlat2 = dot(u_xlat0.zw, float2(12.9898005, 78.2330017));
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 * 43758.5469;
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 + -0.5;
    u_xlat0.x = fma(u_xlat2, FGlobals._HorizontalShake, u_xlat0.x);
    u_xlat2 = input.TEXCOORD0.y + FGlobals._VerticalJump.xyxx.y;
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 + (-input.TEXCOORD0.y);
    u_xlat0.y = fma(FGlobals._VerticalJump.xyxx.x, u_xlat2, input.TEXCOORD0.y);
    u_xlat4 = u_xlat0.y + FGlobals._ColorDrift.xyxx.y;
    u_xlat1.xyw = fract(u_xlat0.xyy);
    u_xlat2 = sin(u_xlat4);
    u_xlat2 = fma(u_xlat2, FGlobals._ColorDrift.xyxx.x, u_xlat0.x);
    u_xlat0.xz = _MainTex.sample(sampler_MainTex, u_xlat1.xy).xz;
    output.SV_Target0.xz = u_xlat0.xz;
    u_xlat1.z = fract(u_xlat2);
    u_xlat0.x = _MainTex.sample(sampler_MainTex, u_xlat1.zw).y;
    output.SV_Target0.y = u_xlat0.x;
    output.SV_Target0.w = 1.0;
    return output;
}


-- Vertex shader for "glcore":
Shader Disassembly:
#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in  vec4 in_POSITION0;
in  vec2 in_TEXCOORD0;
out vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 _Time;
uniform 	vec2 _ScanLineJitter;
uniform 	vec2 _VerticalJump;
uniform 	float _HorizontalShake;
uniform 	vec2 _ColorDrift;
uniform  sampler2D _MainTex;
in  vec2 vs_TEXCOORD0;
layout(location = 0) out vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat10_0;
vec4 u_xlat1;
vec4 u_xlat10_2;
float u_xlat3;
bool u_xlatb3;
float u_xlat6;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.y;
    u_xlat0.yz = _Time.xx;
    u_xlat0.x = dot(u_xlat0.xy, vec2(12.9898005, 78.2330017));
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 43758.5469;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
    u_xlatb3 = abs(u_xlat0.x)>=_ScanLineJitter.xxxy.w;
    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat3 = u_xlat3 * _ScanLineJitter.xxxy.z;
    u_xlat0.x = u_xlat0.x * u_xlat3 + vs_TEXCOORD0.x;
    u_xlat0.w = 2.0;
    u_xlat3 = dot(u_xlat0.zw, vec2(12.9898005, 78.2330017));
    u_xlat3 = sin(u_xlat3);
    u_xlat3 = u_xlat3 * 43758.5469;
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 + -0.5;
    u_xlat0.x = u_xlat3 * _HorizontalShake + u_xlat0.x;
    u_xlat3 = vs_TEXCOORD0.y + _VerticalJump.y;
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 + (-vs_TEXCOORD0.y);
    u_xlat0.y = _VerticalJump.x * u_xlat3 + vs_TEXCOORD0.y;
    u_xlat6 = u_xlat0.y + _ColorDrift.y;
    u_xlat1.xyw = fract(u_xlat0.xyy);
    u_xlat3 = sin(u_xlat6);
    u_xlat3 = u_xlat3 * _ColorDrift.x + u_xlat0.x;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    SV_Target0.xz = u_xlat10_2.xz;
    u_xlat1.z = fract(u_xlat3);
    u_xlat10_0 = texture(_MainTex, u_xlat1.zw);
    SV_Target0.y = u_xlat10_0.y;
    SV_Target0.w = 1.0;
    return;
}

#endif


-- Fragment shader for "glcore":
Shader Disassembly:
// All GLSL source is contained within the vertex program

 }
}
}