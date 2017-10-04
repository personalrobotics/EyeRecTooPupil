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

For help on installing dependencies openCV and libjpeg-turbo, see Pupil Lab’s official Linux developer guide here:
https://docs.pupil-labs.com/#linux-dependencies.

**Note**: You may need to edit the .pro file to point to the install locations of these dependencies. 
I’m working on making this process smoother.

To run the **Pupil Labs** headset, you will need to install the UVC Engine plugin first :
https://github.com/personalrobotics/uvc_engine_pupil. This is dependency 3 listed above.

**Note**: Building the UVC Engine from the above repo will install it as a Qt plugin. If 
the make process finishes, you’re probably good to go.

Also remember that you’ll need Qt 5.7.0 to actually build and run EyeRecToo, just like the UVC Engine.

## Running

Once you’ve finished the above, you just need to add the locations of your openCV and libjpeg-turbo 
to your $LD_LIBRARY_PATH environment variable. You also need to run the built EyeRecToo executable 
with **sudo** so libusb can actually read the USB device names- otherwise, things won’t work.

Also, you might see two entries for each Pupil Camera (so 6 total). Don’t freak over this. One of the 
two entries uses GStreamer, and will probably crash. The other one is using the UVC Engine. Pick that one.

*Both Release and Debug versions are functional although the latter may run at a low sampling rates.*

## Questions

Email sniyaz@cs.washington.edu.

