using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class ReplacementShaderWithColorEffect : MonoBehaviour
{
    public Shader ReplacementShader;

    public Color color;

    private void OnEnable()
    {
        GetComponent<Camera>().SetReplacementShader(ReplacementShader, "");
    }

    private void OnDisable()
    {
        GetComponent<Camera>().ResetReplacementShader();
    }

    private void OnValidate()
    {
        Shader.SetGlobalColor("_OverDrawColor", color);
    }
}
