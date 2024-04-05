Shader "KCH/02_ShaderTexture"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "black" {}
        // 보통은 black 대신 magenta로 지정
        // 반드시 한 장은 _MainTex를 선언해서 지정해줘야 한다.
        _MainTexTo ("Albedo (RGB)", 2D) = "black" {}

        //_ratio ("Ratio", Range(0,1)) = 0 
    }

    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        sampler2D _MainTex;
        sampler2D _MainTexTo;
        half _ratio;

        struct Input
        {
            float2 uv_MainTex;
            //첫번째 텍스쳐는 반드시 uv_MainTex여야 한다. 그래서 Sementic
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			float4 texColor = tex2D (_MainTex, IN.uv_MainTex);
			float4 texToColor = tex2D (_MainTexTo, IN.uv_MainTex);
			//o.Albedo = texColor.rgb; //ALbedo 조명영향을 받은 최종 색깔
            //o.Emission = texColor.r * 0.2989 + texColor.g * 0.5870 + texColor.b * 0.1140; // RGB의 비율을 지정해서 그레이스케일을 만들어주는 설정
            //조명의 영향을 받지 않은 원색
            o.Emission = lerp(texColor.rgb, texToColor.rgb, _ratio);


            // if(texColor.a > 0) 
            //     o.Emission = texColor.rgb;
            // else
            //     o.Emission = texToColor.rgb;       
            // if(texColor.g > 0.5 && texColor.r < 0.4 && texColor.b < 0.3) 
            //     o.Emission = half3(1,0,1);
            // else 
            //     o.Emission = texColor.rgb;
        
        
        }
        ENDCG
    }
    FallBack "Diffuse"
}
