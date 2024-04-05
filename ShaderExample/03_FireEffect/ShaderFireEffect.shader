Shader "KCH/03_FireEffect"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MainTex2 ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
		Tags { "RenderType" = "Transparent" "Queue" = "Transparent" }
        //Transparent = 반투명
        // Queue = 렌더링 순서

        CGPROGRAM
        #pragma surface surf Standard alpha:fade

        sampler2D _MainTex;
        sampler2D _MainTex2;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 c2 = tex2D (_MainTex2, float2(IN.uv_MainTex.x, IN.uv_MainTex.y - _Time.x));
            o.Emission = c.rgb * c2.rgb;
			o.Alpha = c.a * c2.a; // 픽셀당 알파정도가 정해짐

        }
        ENDCG
    }
    FallBack "Diffuse"
}
