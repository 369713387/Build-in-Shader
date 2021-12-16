// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/DoublePassTransparent"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_SecondTex("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 100

		CGINCLUDE
		sampler2D _MainTex;
		sampler2D _SecondTex;

		struct appdata
		{
			float4 vertex : POSITION;
			float2 uv: TEXCOORD0;
		};

		struct v2f
		{
			float4 vertex : SV_POSITION;
			float2 uv: TEXCOORD1;
		};

		v2f vert(appdata v)
		{
			v2f o;
			o.vertex = UnityObjectToClipPos(v.vertex);
			o.uv = v.uv;
			return o;
		}
		ENDCG

		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha
			Cull Off
			ZWrite Off

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog

			#include "UnityCG.cginc"

			fixed4 frag(v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
				return col;
			}
			ENDCG
		}

		Pass
		{
			Cull Front
			ZWrite Off

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog

			#include "UnityCG.cginc"

			fixed4 frag(v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_SecondTex, i.uv);
				return col;
			}
			ENDCG
		}
	}
}
