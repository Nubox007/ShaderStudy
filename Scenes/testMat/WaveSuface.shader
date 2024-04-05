Shader "Custom/WaveSuface"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MainTex2 ("Albedo (RGB)", 2D) = "white"{}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue" = "Transparent"}
        LOD 10

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows noambient vertex:vert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _MainTex2;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainTex2;
        };

        // half _Glossiness;
        // half _Metallic;
        // fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        // UNITY_INSTANCING_BUFFER_START(Props)
        //     // put more per-instance properties here
        // UNITY_INSTANCING_BUFFER_END(Props)


        void vert(inout appdata_full v)
        {
            v.vertex.z += cos(abs(v.texcoord.x * 2-1)*10 + _Time.y)*0.03;
        }

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            //tex2D(_MainTex2,IN.uv_MainTex2+_Time.y);//
            fixed4 c2 = tex2D(_MainTex2, float2(IN.uv_MainTex.x, IN.uv_MainTex.y + _Time.x));
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex + c2.r);
            o.Emission = c.rgb;
            o.Alpha = c.a;
            // Metallic and smoothness come from slider variables
            // o.Metallic = _Metallic;
            // o.Smoothness = _Glossiness;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
