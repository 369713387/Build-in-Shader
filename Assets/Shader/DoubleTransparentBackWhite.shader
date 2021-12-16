Shader "Unlit/DoubleTransparentBackWhite"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" }
        LOD 100

        CGINCLUDE
        sampler2D _MainTex;

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
            Blend SrcAlpha OneMinusSrcAlpha
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
                //获取UV信息
                fixed4 col = tex2D(_MainTex, i.uv);
                //获取所有透明的部分
                float alpha = col.a;
                float4 white = (1,1,1,1);
                //将所有不透明的部分设置为白色
                col = lerp(white,col, 1 - alpha);
                return col;
            }
            ENDCG
        }
    }
}
