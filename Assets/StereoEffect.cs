using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;  // Make sure you include this for button functionality

public class StereoEffect : MonoBehaviour
{
    public Material stereoMaterial;  // The material to apply
    public Button toggleButton;      // The button to toggle the material
    private bool isEffectEnabled = false;  // Track if the effect is enabled or not

    void Start()
    {
        // Screen.SetResolution(1280, 720, true);
        // Set up the button listener to trigger the toggle
        if (toggleButton != null)
        {
            toggleButton.onClick.AddListener(ToggleEffect);
        }
    }

    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        if (stereoMaterial != null && isEffectEnabled)
        {
            Graphics.Blit(src, dest, stereoMaterial); // Apply the material if enabled
        }
        else
        {
            Graphics.Blit(src, dest);  // Use default rendering if not enabled
        }
    }

    // Function to toggle the effect on and off
    void ToggleEffect()
    {
        isEffectEnabled = !isEffectEnabled;  // Toggle the state
    }
}
