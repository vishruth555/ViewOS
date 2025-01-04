# ViewOS: Immersive Virtual Reality Application

This project implements a custom Unity shader called `StereoEffect` designed to create a stereoscopic effect by offsetting texture UVs for simulated left and right eye views. The shader has been optimized for mobile devices and tested across multiple phone models.

## Features

- Custom shader written in HLSL
- Adjustable stereo offset via a material property
- Optimized for lower-end Android devices using `half` precision
- Compatibility with mobile GPUs through minimal branching and clamped UV coordinates

## How to use

1. **Import the Shader**: Copy the `StereoEffect.shader` file into your Unity project under `Assets/Shaders/`.
2. **Create a Material**:
   - Right-click in the Unity Editor's Project window.
   - Select `Create > Material`.
   - Assign the `StereoEffect` shader to the material.
3. **Adjust the Offset**: Modify the `_Offset` property in the material to control the stereo effect.
4. **Assign to Object**: Apply the material to any object in your scene that uses a texture.

## Optimization Notes

- The shader uses `half` precision to reduce computation overhead on mobile devices.
- UV coordinates are clamped to prevent sampling outside the texture bounds, ensuring compatibility with lower-end GPUs.
- Conditional branching has been replaced with mathematical operations to improve performance.

## Known Issues

- Some phones with outdated or buggy GPU drivers may still experience freezes. To mitigate this, the shader includes a fallback to a simpler shader for these devices.

## Demo

Demo files illustrating the shader in action are included in the `Demo Files` folder:

- **Demo 1**: Video showing the stereoscopic effect (`demo1.mp4`)
- **Demo 2**: Screenshot of the shader applied to a textured plane (`demo2.png`)

## Compatibility

- Shader Model: 2.0 and above
- Tested on:
  - Low-end Android devices
  - Mid-range Android devices
  - High-end Android devices

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Contact

For questions, feedback, or bug reports, feel free to contact me at vishruth555\@gmail.com.

