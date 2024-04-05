Shader "KCH/07_Fresnel"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpMap ("NormalMap", 2D) = "bump" {}
		_RimColor ("RimColor", Color) = (1, 1, 1, 1)
		_RimPower ("RimPower", Range(0, 10)) = 3
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
		sampler2D _BumpMap;
		float4 _RimColor;
		float _RimPower;

        struct Input
        {
            float2 uv_MainTex;
			float2 uv_BumpMap;
			float3 viewDir; // 카메라가 바라보고 있는 방향, 반드시 이 이름으로 선언해야한다.
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			float rim = saturate(dot(o.Normal, IN.viewDir));

            if(rim > 0.3) rim = 1;
            else rim = -1;

		    o.Emission = pow(1 - rim,_RimPower) * _RimColor.rgb * -1; 
            o.Alpha = c.a ;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
