// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/TranslateShader"
{
    Properties
    {
		_MainTex("Main Text", 2D) = "white" {}
		_DisplacementTex("Displacement Texture", 2D) = "white" {}
		_Magnitude("Magnitude", Range(0, 1)) = 0
		_Strength("_Strength", Range(0, 1)) = 0
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

            #include "UnityCG.cginc"

			sampler2D _MainTex;
			sampler2D _DisplacementTex;
			float _Magnitude;
			float _Strength;
			// 获取模型数据
			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};
			// 存放计算结果
			struct v2f
			{
				float2 uv : TEXCOORD1;
				float4 vertex : SV_POSITION;
			};
			// 拿取模型数据计算后传给fragment shader
			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				UNITY_TRANSFER_FOG(o, o.vertex);
				return o;
			}
			// 拿取计算结果作用于目标
			float4 frag(v2f i) : SV_Target
			{
				
				float2 distuv = float2(i.uv.x + _Time.x * _Strength,i.uv.y + _Time.y * _Strength);

				float2 disp = tex2D(_DisplacementTex, distuv).xy;

				disp = ((disp * 2) - 1) * _Magnitude;

				float4 col = tex2D(_MainTex, i.uv + disp);

				return col;
			}

            ENDCG
        }
    }
}
