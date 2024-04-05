# ShaderStudy
# 쉐이더

### Rendering Pipeline

기본적으로 컴퓨터가 3차원의 물체를 그리기 위해서는 3개의 축(x, y , z)에 대한 좌표을 바탕으로 
3차원의 세계를 정의한 뒤, 해당 좌표를 기준으로 물체의 크기와 모양 등을 그려낼 수 있다. 

이때, 3차원 세계에서 물체의 위치를 나타내는 것을 전역좌표(World Space Position) 이라고 한다.
이 좌표를 기준으로 물체를 구성하는 각 꼭짓점들을 극점(Vertex)이라고 하며 이 극점들의 위치를 나타내기 위해 필요한 것이 지역좌표(Local Spcae Position) 이다. 각 극점들은 이 좌표를 기준으로 얼마나 멀리 떨어져있는지 나타낼 수 있으며 이를 통해 물체의 꼭짓점들을 나타낼 수 있다. 이 극점들을 알맞은 순서에 맞게 연결하여 물체의 형태를 그려낼 수 있다.
![](./image.jpg)

![](./RenderingPipe.png)

이 단계를 **Input Assembler**라고 하며 정점들의 위치와 연결되는 인덱스 값들을 버퍼에 전달하여 선형으로 그려낼 수 있다. 이때, 정점들이 연결되는 모양새는 반드시 삼각형으로 생성되며 삼각형으로 만들어야지 **노말벡터(Normal Vector)** 즉, 해당 면의 수직 벡터를 구할 수 있기 때문이다. 

그래픽카드의 GPU들은 기본적으로 이 삼각형을 빠르게 그려낼 수 있다고한다.

이제 3차원의 물체를 우리가 바라보고 있는 방향으로 그려내기 위한 처리를 해야한다.
이걸 처리하기 위해 행렬변환이라는 선형대수를 사용하여 각 위치에 대한 정보를 변환해야한다. 이 과정을 공간 변환이라고 한다. Model -> View -> Projection 순으로 변환처리가 되며 마지막 Projection 변환과정에서 화면에 나타낼 부분을 정의할 **절두체** 라고 하며 이 절두체는 Near Cliping Plane, Far Cliping Plane, Field of View 들에 의해 정의되며 이 절두체 영역 내에 있지 않은 물체들은 모두 그릴 필요없기에 **Clipng** 된다. 

![](./Frustum.png)

이후 **Resterization**이라는 과정을 거치며 이 과정에서 앞선 과정에서 그려진 도형을 화면에 표시하기 위해서 각 정점데이터를 픽셀데이터로 변환하는 과정이다. 

![](./Rasterization.png)

이 과정에서 **뷰포트 변환(ViewPort Transformation)** , **스캔변환(Scan Transformation)** 등의 과정을 거치며 이렇게 변환된 정보를 가지고 **Pixel Shader(Fragment Shader)** 에서 화면에 나타낼 색을 표현해낸다. 

이 Pixel Shader과정에서 흔히 말하는 쉐이더의 기능들이 적용되며 여기서 각 픽셀들을 색을 계산하여 물체가 가진 색에 대한 표현을 나타낼 수 있다. 이 과정에서 물체에 적용되는 텍스쳐, 투명도, 그림자, 다양한 빛 처리를 처리할 수 있다. 이때, 멀리 있는 물체와 가까이 있는 물체의 순서가 있어야 물체 간의 원근감이나 뒤의 물체가 앞의 물체를 가리는 이상한 현상을 없앨 수 있다.

--------------------------

### Shader

컴퓨터 그래픽스의 발전이 먼저 사용되는 곳은 영화

- 미리 렌더링 해서 완성된 출력물을 상영, 그렇기 때문에 그래픽 기술의 한계가 없음
​

게임은 실시간 렌더링을 해야하기 때문에 기술 적용이 좀 더 시간이 걸림

고정 파이프라인을 커스텀하기 시작, 제일 처음 적용된 작품은 **토이스토리 1**-

그래픽 연산을 빠르게 하기 위해 그래픽 카드사에서는 고정 파이프라인을 칩으로 집어 넣게 되었음 하지만 고정된 틀에 의해서 나오는 결과물이 너무 고착화 되니깐 개발자들의 불만이 많았음. 그래서 고정 파이프라인의 일부분을 개방해주고자 함.​

즉, 고정 파이프라인의 일부분을 커스터마이징 할 수 있게 해주는 것이 쉐이더, Direct X 8.0부터 쉐이더라는 것이 언급되기 시작하였다.

DirectX 9.0 이전

- Vertex Shader

- Pixel Shader
​

DirectX 10.0 이후

- Geometry Shader 
​

DirectX 11.0 이후

- Computer Shader (OpenCl, CUDA)

- Hull Shader

- Tessellator

- Domain Shader

​


|DirectX|OpenGl|
|:--:|:--:|
|Vertex Shader    |  Vetex Programming|
|Pixel Shader | Fragment Programming |
|HLSL(High Level Sahding Language) | GLSL(OpenGL Shading Language)|
|Geometry Shader|Geometry Shader|
|Hull Shader|Tessellation Control Shader|
|Domain Shader     |Tessellation Evaluation Shader|


셰이더 코드는 우리가 기존에 사용하는 코드 작성 방법과는 다르다. 어셈블리어 라는 것을 활용해서 코드를 짜야 하는데 그것이 힘드니 사람들이 조금 더 편안하게 할 수 있도록 **HLSL**과 같은 셰이더를 C언어 느낌으로 쓸 수 있게 만들어 주는 것이 있다.

또한 픽셀 셰이더 와 정점 셰이더의 경우 코드 작성 방식이 다른데 이러한 점들이 초보자들에게는 사용하기 어려운 점이 있었다.​

유니티에서는 Nvidia에서 쓰는 CG라는 방식, HLSL, GLSL 등과 같은 코드 작동 방식을 섞어서 한 군데서 사용하는 Surface Shader라는 것을 자체적으로 만들었다. 나름의 장단점을 가지고는 있지만 이를 더 진화시켜서 랜더링 파이프 라인을 통째로 건들이는 셰이더 그래프라는 것을 만들면서 대격변을 일으켰다.

이로인해 나온 것이 URP, HDRP 등으로 애니메이션을 만드는 노드 방식으로 셰이더를 다룰 수 있게 되었다.​ 서피스 셰이더에서는 픽셀, 정점 셰이더를 같이 다룰 수 있다.​


```CSharp
Shader "01_Color" // 쉐이더 파일명
{
	Properties
	{
		_colorR ("Color R", Range(0, 1)) = 1
		_colorG ("Color G", Range(0, 1)) = 1
		_colorB ("Color B", Range(0, 1)) = 1

		_Metallic ("Metallic", Range(0, 1)) = 1
		_Glossiness ("Glossiness", Range(0, 1)) = 1
	}

    
    // 위의 코드들은 이 쉐이더 코드에서 나타낼 속성 값들을 나타낸다.
    // 유니티 Serialize같이 외부에서 속성들 값에 접근해서 조절할 필요가 있는 값들을 선언하여 사용자가 조절할 수 있게 한디. 

```
이 때 '_colorR' 과 같은 외부에서 값을 받거나 외부와 연결된 것은 전부 _를 붙여야 한다. 그런데 _color의 경우 변수명이 아니다. 외부와 내부 사이의 중간 쯤에 있는 것이라고 생각하면 된다.

**("문자열")** 의 경우  인스펙터에서 보여줄 문자열을 말하며, **Range(0, 1)** 의 경우 우리가 아는 범위를 지정하는 Range는 맞지만 이 Range의 자리는 원래 자료형이 들어가는 자리이다.

즉 , 이를 정리하면 color라는 것을 만들 건데 외부에서는 "문자열" 이라는 이름으로 보일 것이고 이 범위 사이를 움직일 수 있게 할 것이다 라는 의미로 해석할 수 있을 것이다.


```CSharp
	SubShader
	{
		CGPROGRAM 

        //CGPROGRAM의 경우 Nvidia(CG 코드) 코드 작동법으로 돌아가는 범위를 시작하겠다는 의미를 나타낸다.
        //SubShader의 의미는 한번에 하나의 셰이더가 돌아가지 않기 때문인데 셰이더에서는 패스라고 해서 여러개가 돌아갈 수 있다. 그렇기 때문에 SubShader라는 것이 들어가는 것이다.

		#pragma surface surf Standard


        //# 이 들어가면 전처리기, 라는 의미이다. 컴파일 할 때 옵션을 정하는 것이다.
        //Standard는 제일 기본적인 셰이더를 기본옵션으로 쓰겠다는 뜻이다. 다만, 여기서 Standard를 쓰게 되면 유니티가 생각한 기본 옵션이 풀옵션이기 때문에 물리기반의 렌더링하는 풀옵션으로 파이프라인을 돌리게 된다.

		struct Input
		{
			float4 color : COLOR;
		};
        // 기본적으로 파이프라인을 통해 지나가는 데이터들을 가져와서 재가공 후 넘겨주는 방식으로 쉐이더가 동작한다. 이 코드에서는 그 데이터의 일부를 가져와서 속성을 가공한다. 이를 Sementic 이라고 한다.
        // surf메서드는 CallBack 메서드 처럼 형식이 정해져있는 메서드이다. 사용하기 위해서는 Input 구조체의 내용이 필요하며, 사용할 내용이 없더라도 선언은 해야 surf를 사용할 수 있다. 

		fixed _colorR;
		fixed _colorG;
		fixed _colorB;

		half _Metallic;
		half _Glossiness;

        // 실제 변수 선언을 한 곳이다.
        // shader 코드에서는 기본적으로 실수 값만 사용하며, 
        /*
        float   4byte 
        fixed   11bit -> 일반적은 자료형은 맨처음 비트가 부호비트이고 색이나 UV를 지정할때는 음수로 지정하면 안되기에 부호를 뺀 11bit만을 사용한다.
        half    2byte -> NVdia의 그래픽카드의 경우, half 체재로 설계되어 half 자료형에 대한 계산이 빠르다.
        */
		//struct SurfaceOutputStandard
		//{
		//	fixed3 Albedo;		//	반사되는 색
		//	fixed3 Normal;		//	법선
		//	half3 Emission;		//	발산되는 색
		//	half Metallic; 		//	0 = 메탈 영향 없음, 1 = 메탈
		//	half Smoothness		//	0= 거칠게, 1 = 부드럽게
		//	half Occlusion;		//	차폐로 인한 환경광의 영향도 (기본 1)
		//	fixed Alpha;		//	투명도
		//};
        // SurfaceOutputStandard 구조체에 들어가있는 내용이다.
    
		void surf(Input In, inout SurfaceOutputStandard 0)
		{
			o.Albedo = float3(_colorR, _colorG, _colorB);
            //Albedo는 빛처리를 받은 최종적으로 마무리된 픽셀값을 나타낸다.
            //Emission는 빛 처리를 받기 이전의 원색을 나타낸다.
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
		}
		ENDCG
	}
}

```
----------------------------

```
void surf (Input IN, inout SurfaceOutputStandard o)
{
	float4 texColor = tex2D (_MainTex, IN.uv_MainTex);
	float4 texToColor = tex2D (_MainTexTo, IN.uv_MainTex);
	o.Emission = lerp(texColor.rgb, texToColor.rgb, _ratio);
}
```
위 코드는 쉐이더에 텍스쳐를 오브젝트의 UV에 맞춰 입혀주고, 해당 UV에 맞는 픽셀 색상값을 보간 처리하여 0 ~ 1까지로 지정하여 얼마나 섞을지 나타낸다. 0에 가까울 수록 texColor에 가까운 색으로, 1에 가까울 수록 texToColor의 색으로 나타낸다.

또한 경우에 따라 같은 물체에 다른 색을 적용해야하는 경우가 있을 것이다. 이때, 절대 사용하지 않을 색 (ex.마젠타 색)으로 나타내고 이를 코드 상에서 팀 컬러를 넘겨주어 색을 넘겨주는 방식으로 색상 구분을 나타낼 수 있다.


![](./Mutal_shader.png) ![](./mutal_aftershader.png)

-------------------

```
o.Emission = IN.uv_MainTex.x;
// 색상 값을 UV.x 값으로 나타낸다.
```

![](./UV.png)

위 코드를 적용하면 다음과 같이 적용된다.


UV는 적용시킬려는 텍스쳐의 색상을 어떤 위치에 입힐지 지정할 수 있게 하는 개념이다.
![](./UV_OPGL_DX.png)
위와 같이 그래픽 라이브러리에 대한 UV 위치가 다르며 Unity의 경우 OpenGL 처럼 왼쪽 아래에서 시작한다.

시작 위치부터 끝까지 0 부터 1까지 실수형으로 나타나며 텍스쳐도 같은 방식으로 해당위치의 색상 값을 가져와서 화면에 픽셀 값으로 나타낸다.


코드에서 살짝 수정으로 UV 위치를 조정할 수 있으며, 이를 통해 텍스쳐 애니메이션이 가능하다.


```CSharp


Shader "03_FireEffect"
{
	Properties
	{
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_MainTex2 ("Albedo (RGB)", 2D) = "white" {}
	}

	SubShader
	{
		Tags { "RanderType" = "Transparent" "Queue" = "Transparent" }

		CGPROGRAM
		#pragma surface surf Standard alpha:fade

		smapler2D _MainTex;
		smapler2D _MainTex2;

		struct Input
		{
			float2 uv_MainTex;
		}

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			fixed4 c2 = tex2D (_MainTex2, float2(IN.uv_MainTex.x, IN.uv_MainTex.y - _Time.y));

			o.Emission = c.rgb * c2.rgb;
			o.Alpha = c.a * c2.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}

```


