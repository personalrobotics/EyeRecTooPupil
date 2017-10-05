# EyeRecToo

Original GitLab link: https://atreus.informatik.uni-tuebingen.de/santini/EyeRecToo

This is the PRL fork of EyeRecToo, a gaze tracking software suite. This software, along with the UVC Engine,
enables eye and gaze tracking with the Pupil Labs headset. Changes have been made to allow building and running on 
Ubuntu 14.04. This repo assumes use of the Pupil Labs headset.

## Dependencies and Building

Running EyeRecToo on Ubuntu with the Pupil Labs headset requires the following dependencies:

1. openCV 3.2.0
2. libjpeg-turbo
3. uvcengine

To run the **Pupil Labs** headset, you will need to install the UVC Engine plugin first :
https://github.com/personalrobotics/uvc_engine_pupil. This is dependency 3 listed above.

**Note**: Building the UVC Engine from the above repo will install it as a Qt plugin. If 
the make process finishes, you’re probably good to go.

Also remember that you’ll need Qt 5.7.0 to actually build and run EyeRecToo, just like the UVC Engine.
Make sure to build everything (EyeRecToo and UVC Engine) in release mode with Qt.

*Both Release and Debug versions are functional although the latter may run at a low sampling rates.*

## Installing OpenCV 3.2.0
This can be a little tricky. EyeRecToo requires OpenCV to be built and installed with the extra modules like Aruco. 
In addition, building with the extra modules seems to be broken on Master for OpenCV at the time of writing (10/4/17). 

First, download version 3.2.0 of OpenCV and the extra modules from these URLs:
OpenCV 3.2.0: https://github.com/opencv/opencv/releases/tag/3.2.0
OpenCV 3.2.0 Extra Modules: https://github.com/opencv/opencv_contrib/releases/tag/3.2.0

Now extract both zip files in the same location (i.e. your home folder). Follow these steps:

`cd opencv-3.2.0`

`mkdir build`

`cd build`

`cmake -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-3.2.0/modules/ -D CMAKE_BUILD_TYPE=RELEASE ..`

`make`

`sudo make install`

`sudo ldconfig`

This will build and install OpenCV 3.2.0 with the extra modules.

## Installing libjpeg-turbo

Much simpler. From the Pupil Linux docs:

`wget -O libjpeg-turbo.tar.gz https://sourceforge.net/projects/libjpeg-turbo/files/1.5.1/libjpeg-turbo-1.5.1.tar.gz/download`

`tar xvzf libjpeg-turbo.tar.gz`

`cd libjpeg-turbo-1.5.1`

`./configure --with-pic --prefix=/usr/local`

`sudo make install`

`sudo ldconfig`

**Note**: You may need to edit the .pro file to point to the install locations of these dependencies. 
Assuming you start from scratch and follow these directions, you shouldn't have to.

## Running

Once you’ve finished the above, you just need to add the locations of your openCV and libjpeg-turbo 
to your $LD_LIBRARY_PATH environment variable. You also need to run the built EyeRecToo executable 
with **sudo** so libusb can actually read the USB device names- otherwise, things won’t work.

The following command should work if you've followed this guide (it's a bit hacky though):

`sudo LD_LIBRARY_PATH=/usr/local/lib/ ./EyeRecToo`

Also, you might see two entries for each Pupil Camera (so 6 total). Don’t freak over this. One of the 
two entries uses GStreamer, and will probably crash. The other one is using the UVC Engine. Pick that one.

## Questions

Email sniyaz@cs.washington.edu.

