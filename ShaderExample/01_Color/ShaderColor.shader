// https://docs.unity3d.com/Manual/SL-SurfaceShaders.html

Shader "KCH/01_Color" // 파일명
{
	Properties
	{
		_colorR ("Color R", Range(0, 1)) = 1			//중간변수(변수 X) / 인스펙터 이름 / (원래는 자료형)범위지정 / 현재 값
		_colorG ("Color G", Range(0, 1)) = 1
		_colorB ("Color B", Range(0, 1)) = 1	
	

		_Metallic ("Metallic", Range(0, 1)) = 1 		// 매끄럽게
		_Glossiness ("Glossiness", Range(0, 1)) = 1 	// 거칠게
	}

	SubShader
	{
		CGPROGRAM 	//범위 지정
					// CG 기반의 코드

		// #pragma surface surfaceFunction lightModel [optionalparams]
		#pragma surface surf Standard 	//#pragma 컴파일러가 컴파일할 때 어떤 설정으로 컴파일할지 지정한다.
										//Unity가 만들어 놓은 suface 쉐이더를 사용하겠다고 선언
										//Unity는 standard가 풀옵션이다. 물리기반 렌더링을 적용한다.

		struct Input
		{
			float4 color : COLOR; 
			//Sementic
			//파이프라인에서 사용할 정보를 선언
		};


		// 실제 변수를 선언하는 곳
		fixed _colorR;
		fixed _colorG;
		fixed _colorB;

		half _Metallic;
		half _Glossiness;

		//struct SurfaceOutputStandard
		//{
		//	fixed3 Albedo;      // 반사되는 색
		//	fixed3 Normal;      // 법선
		//	half3 Emission;		// 발산되는 색
		//	half Metallic;      // 0 = 메탈 영향 없음, 1 = 메탈
		//	half Smoothness;    // 0 = 거칠게, 1 = 부드럽게
		//	half Occlusion;     // 차폐로 인한 환경광의 영향도 (기본 1)
		//	fixed Alpha;        // 투명도
		//};



		// CallBack처럼 함수의 형태가 정해져있다.
		void surf(Input In, inout SurfaceOutputStandard o) 
		{	
			//In.color = _colorR;
			o.Albedo = float3(_colorR, _colorG, _colorB);
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
		}

		ENDCG
	}
}