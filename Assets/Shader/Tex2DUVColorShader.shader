Shader "Unlit/Tex2DUVColorShader"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_Color("Color",color) = (1,1,1,1)
	}
		SubShader
	{
		Tags { "Queue" = "Transparent" }

		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
		// make fog work
		#pragma multi_compile_fog

		sampler2D _MainTex;
		float4 _Color;

		#include "UnityCG.cginc"

		struct appdata
		{
			float4 vertex : POSITION;
			float2 uv : TEXCOORD0;
		};

		struct v2f
		{
			float2 uv : TEXCOORD1;
			float4 vertex : SV_POSITION;
		};

		v2f vert(appdata v)
		{
			v2f o;
			o.vertex = UnityObjectToClipPos(v.vertex);
			o.uv = v.uv;
			return o;
		}

		fixed4 frag(v2f i) : SV_Target
		{
			float4 color = fixed4(i.uv.r,i.uv.g,0,1);

			return tex2D(_MainTex,i.uv) * color;
		}
	ENDCG
}
	}
}
