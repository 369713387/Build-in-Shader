using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class ReplacementTexTureShaderEffect : MonoBehaviour
{
    public Shader ReplacementShader;

    public Texture _MainTex;

    public Texture _SecondTex;

    public GameObject plane_1;

    public GameObject plane_2;

    private void OnEnable()
    {
        GetComponent<Camera>().SetReplacementShader(ReplacementShader, "RenderType");

        plane_1.GetComponent<MeshRenderer>().material.SetTexture("_MainTexture",_MainTex);
        plane_1.GetComponent<MeshRenderer>().material.SetTexture("_SecTexture",_SecondTex);
        plane_2.GetComponent<MeshRenderer>().material.SetTexture("_MainTexture",_MainTex);
        plane_2.GetComponent<MeshRenderer>().material.SetTexture("_SecTexture",_SecondTex);
    }

    private void OnDisable()
    {
        GetComponent<Camera>().ResetReplacementShader();
    }
}
