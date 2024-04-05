Shader "KCH/09_NPR2Pass"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

		cull front
        // 앞면을 컬링한다.

		// Pass 1
        CGPROGRAM
        #pragma surface surf Nolight vertex:vert noshadow noambient

		void vert(inout appdata_full v) // appdata_full 파이프라인내의 구조체 내용을 전부 들고 온다.
        {
			v.vertex.xyz += v.normal.xyz * 0.005;
		}

        struct Input { float4 color:COLOR; };

        void surf (Input IN, inout SurfaceOutput o) {}

		float4 LightingNolight (SurfaceOutput s, float3 lightDir, float atten) 
        {
			return float4(1, 0, 1, 1);
		}
		ENDCG

		cull back
        //뒷면을 컬링한다.

		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;

		struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
