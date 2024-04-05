using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//[ExecuteInEditMode]
public class TextureRatio : MonoBehaviour
{
   

    [SerializeField] private MeshRenderer mr = null;
    [SerializeField, Range(0f, 1f)]private float ratio = 0f;
    

    private void Awake()
    {
        mr = GetComponent<MeshRenderer>();
    }

    private void Update()
    {
        mr.material.SetFloat("_ratio",ratio);
    }


}
