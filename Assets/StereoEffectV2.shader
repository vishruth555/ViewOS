Shader "Custom/StereoVignetteEffect"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Offset ("Stereo Offset", Float) = 0.02
        _VignetteStrength ("Vignette Strength", Float) = 0.5
        _VignetteRadius ("Vignette Radius", Float) = 0.8
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            sampler2D _MainTex;
            float _Offset;
            float _VignetteStrength;
            float _VignetteRadius;

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

            fixed4 frag (v2f i) : SV_Target
            {
                // Calculate the stereo offset based on eye (left or right)
                float2 offsetUV = i.uv;

                // Apply a stereo offset for left and right eye
                // For left eye, apply negative offset, for right eye apply positive offset
                offsetUV.x += (i.uv.x < 0.5 ? -_Offset : _Offset);

                // Sample the texture
                fixed4 color = tex2D(_MainTex, offsetUV);

                // Calculate the center for each eye (left and right) in screen space
                float2 center = (i.uv.x < 0.5) ? float2(0.25, 0.5) : float2(0.75, 0.5);
                float2 uvDist = i.uv - center;

                // Calculate the distance from the center of the eye's viewport
                float dist = length(uvDist);

                // Invert the vignette effect: Darken the edges instead of the center
                // Calculate the vignette effect where the edges are darkened
                float vignette = smoothstep(_VignetteRadius, _VignetteRadius + 0.2, dist);

                // Darken the edges of the screen (higher strength = darker edges)
                // The center will remain untouched while the edges get darker
                color.rgb *= lerp(1.0, 1.0 - _VignetteStrength, vignette);

                return color;
            }
            ENDCG
        }
    }
}
