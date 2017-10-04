# EyeRecToo

Original GitLab link: https://atreus.informatik.uni-tuebingen.de/santini/EyeRecToo

This is the PRL fork of EyeRecToo, a gaze tracking software suite. This software, along with the UVC Engine,
enables eye and gaze tracking with the Pupil Labs headset. Changes have been made to allow building an running on 
Ubuntu 14.04.

## Supported Devices

Theoretically, cameras using DirectShow (on Windows) and v4l2 (on Linux)
should work out of the box.

*Tested Eye Trackers:*
- Dikablis Essential / Pro (see [Ergoneers](http://www.ergoneers.com))
- Pupil DIY (see [Pupil Labs](https://pupil-labs.com/))
- Eivazi's microscope add-on (see [Eivazi, S et al.  2016](http://ieeexplore.ieee.org/document/7329925/))
- Pupil Eye Tracker (see [Pupil Labs](https://pupil-labs.com/store/))
**NOTE:** Early support for Pupil Labs' custom cameras is provided
through the [UVC Engine](https://atreus.informatik.uni-tuebingen.de/santini/uvcengine).
This support was tested with a binocular Pupil headset (in total three cameras) with the
following configurations:
1. Eyes (320 x 240 @120fps) Field (1280 x 720 @30fps)
2. Eyes (640 x 480 @120fps) Field (1280 x 720 @30fps)
3. Eyes (640 x 480 @120fps) Field (640 x 480 @120fps)

Other configurations also work but were not extensively used.

*Please note that the camera driver, libusb, and libuvc can crash if the headset is unplugged
while the cameras are streaming. These are still work in progress for Windows,
and the uvc engine is still in beta.*


*Tested webcams:*
- [Playstation Eye](https://en.wikipedia.org/wiki/PlayStation_Eye)
- [Microsoft LifeCam HD-3000](https://www.microsoft.com/accessories/en-us/products/webcams/lifecam-hd-3000/t3h-00011)
- [Microsoft LifeCam HD-5000](https://www.microsoft.com/accessories/en-us/d/lifecam-hd-5000)
- [Microsoft LifeCam HD-6000](https://www.microsoft.com/accessories/en-us/d/lifecam-hd-6000-for-notebooks)
- [Microsoft LifeCam VX-1000](https://www.microsoft.com/accessories/en-us/d/lifecam-vx-1000)
- [Logitech C920](http://www.logitech.com/en-us/product/hd-pro-webcam-c920)
- [Logitech C510](http://support.logitech.com/en_us/product/hd-webcam-c510)
- [Logitech C525](http://www.logitech.com/en-us/product/hd-webcam-c525)
- [Logitech QuickCam PRO 9000](http://support.logitech.com/en_us/product/quickcam-pro-9000)
- [Logitech QuickCam Express](http://support.logitech.com/en_us/product/quickcam-express)

## Developing

The EyeRecToo official repository is located at:
[https://atreus.informatik.uni-tuebingen.de/santini/EyeRecToo](https://atreus.informatik.uni-tuebingen.de/santini/EyeRecToo)

The particulars of the test build system we use are:
- QtCreator 4.0.3
- Qt 5.7.0 (MSVC 2015, 64 bit)
- Visual Studio 2015
- Microsoft Windows 8.1

All libraries/includes (for Windows 64 bits) should be in the deps directory already; to build:
1. Install Visual Studio 2015
2. Install Qt 5.7.0 (and Qt Creator)
3. Open the project
4. Run qmake and build
5. Before running, add deps/runtime/Release or deps/runtime/Debug to your PATH.

*Both Release and Debug versions are functional although the latter may run at a low sampling rates.*

