using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
public class toggleVR : MonoBehaviour
{
    public Material newMaterial;  // The material to toggle
    public Button toggleButton;   // The UI button that will trigger the toggle
    private bool isMaterialApplied = false;  // Track if the material is applied

    private Camera camera;

    void Start()
    {
        // Get the main camera (or assign a specific camera)
        camera = Camera.main;

        // Set up the button listener to trigger the toggle
        toggleButton.onClick.AddListener(ToggleCameraMaterial);
    }

    void ToggleCameraMaterial()
    {
        if (isMaterialApplied)
        {
            // Remove the material (reset the camera to its default state)
            camera.clearFlags = CameraClearFlags.Skybox; // Or set any other default clear flag
            camera.backgroundColor = Color.black; // Optional: reset the background color
        }
        else
        {
            // Apply the new material to the camera
            camera.clearFlags = CameraClearFlags.SolidColor;
            camera.backgroundColor = Color.black; // Or any color you want as the background
            camera.SetReplacementShader(newMaterial.shader, "RenderType");
        }

        // Toggle the state
        isMaterialApplied = !isMaterialApplied;
    }
}
