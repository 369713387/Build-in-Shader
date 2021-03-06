Shader "Unlit/TweenTex2DShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _ReplaceTex ("Texture", 2D) = "white" {}
        _Tween ("Tween", Range(0, 1)) = 0
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            sampler2D _ReplaceTex;
			float _Tween;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
				//使用两张纹理，当移动滑杆时在两张纹理中进行插值
				float4 tex_color = lerp(tex2D(_MainTex, i.uv), tex2D(_ReplaceTex, i.uv),_Tween);
                return tex_color;
            }
            ENDCG
        }
    }
}
