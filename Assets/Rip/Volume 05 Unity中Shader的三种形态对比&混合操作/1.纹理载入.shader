﻿Shader "浅墨Shader编程/Volume5/18.基本纹理载入" 
{
	//-------------------------------【属性】--------------------------------------
    Properties 
	{
        _MainTex ("基本纹理", 2D) = "black" { }
    }

	//--------------------------------【子着色器】--------------------------------
    SubShader 
	{
		//-----------子着色器标签----------
        Tags { "Queue" = "Geometry" } //子着色器的标签设为几何体

		//----------------通道---------------
        Pass 
		{
			//设置纹理
            SetTexture [_MainTex] { combine texture }
        }
    }
}