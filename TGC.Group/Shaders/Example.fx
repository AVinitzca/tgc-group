
/**************************************************************************************/
/* Variables comunes */
/**************************************************************************************/

//Matrices de transformacion
float4x4 matWorld; //Matriz de transformacion World
float4x4 matWorldView; //Matriz World * View
float4x4 matWorldViewProj; //Matriz World * View * Projection
float4x4 matInverseTransposeWorld; //Matriz Transpose(Invert(World))

float time = 0;

int screenHeight = 0, screenWidth = 0;

//Textura
texture textureExample;
sampler2D textureSampler = sampler_state
{
    Texture = (textureExample);
    ADDRESSU = MIRROR;
    ADDRESSV = MIRROR;
	MINFILTER = LINEAR;
    MAGFILTER = LINEAR;
	MIPFILTER = LINEAR;
};


//Input del Vertex Shader
struct VS_INPUT
{
	float4 Position : POSITION0;
	float2 Texcoord : TEXCOORD0;
};

//Output del Vertex Shader
struct VS_OUTPUT
{
	float4 Position : POSITION0;
	float2 Texcoord : TEXCOORD0;
	float3 MeshPosition : TEXCOORD1;
};

//Vertex Shader
VS_OUTPUT vsDefault(VS_INPUT input)
{
	VS_OUTPUT output;

	output.Position = input.Position;
	output.Texcoord = input.Texcoord;
	output.MeshPosition = input.Position;

	return output;
}

float distanceToShape(int sides, float2 position)
{
	float angle = atan2(position.y, position.x) + 3.14;
	float radius = 3.14 * 2.0 / float(sides);

	return cos(floor(.5 + angle / radius) * radius - angle) * length(position);
}

float2 random2(float2 input)
{
    return frac(sin(float2(dot(input, float2(127.1, 311.7)), dot(input, float2(269.5, 183.3)))) * 43758.5453);
}

float2 rotate2D(float2 position, float angle)
{
	position -= 0.5;
	position = mul(float2x2(cos(angle), -sin(angle), 
						    sin(angle), cos(angle)), position);
	position += 0.5;
	return position;
}

//Pixel Shader
float4 psDefault(VS_OUTPUT input) : COLOR0
{
	float2 position = input.MeshPosition;
    return float4(position.xy, sin(time * 2.0), 1);

}

technique Default
{
	pass Pass_0
	{
		VertexShader = compile vs_3_0 vsDefault();
		PixelShader = compile ps_3_0 psDefault();
	}
}













/*
	float2 points[8];
	points[0] = float2(.8, .6) + float2(sin(time * 1.5), -cos(time * 2)) * 0.3;
	points[1] = float2(.1, .1) + float2(sin(time * 0.5), -cos(time)) * 1.0;
	points[2] = float2(.4, .8) + float2(sin(time * 0.5), -cos(time)) * 0.2;
	points[3] = float2(.8, .2) + float2(sin(time), cos(time)) * 0.5;
	points[4] = float2(-1.0, .5) + float2(sin(time * 0.5), -cos(time)) * 0.63;
	points[5] = float2(0.0, .25) + float2(sin(time * 0.5), -cos(time)) * 0.63;
	points[6] = float2(-0.6, .5) + float2(sin(time * 0.5), -cos(time)) * 0.63;
	points[7] = float2(1.0, .15) + float2(sin(time * 0.5), -cos(time)) * 0.63;




position += 1.0;
    position *= 2.5;
    float2 cell = floor(position);
    float minDistance = 2;
    
    for (float x = -5.0; x <=5.0; x++)
        for (float y = -5.0; y <= 5.0; y++)
        {
            float2 currentCell = cell + float2(x, y);
            float2 rand = random2(currentCell / 5.0);
            rand = 0.5 + 0.5 * sin(time + 6.2831 * rand);            
            float distanceToPoint = distance(rand + currentCell, position);
            distanceToPoint *= distanceToPoint;
            if (minDistance > distanceToPoint)
            {
                minDistance = distanceToPoint;                
            }
        }
    
    float white = minDistance * minDistance;
    
    float4 color = float4(1.0 + white + 0.2, white + 0.75, 1.0, 1.0);
    return color; 
*/