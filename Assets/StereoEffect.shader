Shader "Custom/StereoEffect"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Offset ("Stereo Offset", Float) = 0.02
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200 // Lower LOD for mobile performance

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            sampler2D _MainTex;
            float _Offset;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                // Apply the stereo offset with minimal branching
                half2 offsetUV = i.uv;
                offsetUV.x += (i.uv.x < 0.5f) ? -_Offset : _Offset;
                
                // Use half precision for texture sampling
                return tex2D(_MainTex, offsetUV);
            }
            ENDCG
        }
    }

    // Fallback to use a simpler shader if the hardware doesn't support it
    Fallback "Diffuse"
}
