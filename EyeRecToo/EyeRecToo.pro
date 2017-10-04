QT       += core gui multimedia

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TOP = $$PWD

TARGET = EyeRecToo
TEMPLATE = app
win32: RC_ICONS = $${TOP}/icons/eyerectoo.ico

# For profiling with msvc
#TEMPLATE = vcapp

DEFINES += TURBOJPEG

# Note: Starburst and Swirski are not currently included in the repository; do not enable
#DEFINES += STARBURST
#DEFINES += SWIRSKI

SOURCES +=\
    $${TOP}/src/main.cpp\
    $${TOP}/src/MainWindow.cpp \
    $${TOP}/src/utils.cpp\
    $${TOP}/src/FrameGrabber.cpp \
    $${TOP}/src/Camera.cpp \
    $${TOP}/src/ImageProcessor.cpp \
    $${TOP}/src/EyeImageProcessor.cpp \
    $${TOP}/src/pupil-detection/ElSe.cpp \
    $${TOP}/src/pupil-detection/ExCuSe.cpp \
    $${TOP}/src/CameraWidget.cpp \
    $${TOP}/src/FieldImageProcessor.cpp \
    $${TOP}/src/Synchronizer.cpp \
    $${TOP}/src/GazeEstimationWidget.cpp \
    $${TOP}/src/GazeEstimation.cpp \
    $${TOP}/src/gaze-estimation/PolyFit.cpp \
    $${TOP}/src/gaze-estimation/Homography.cpp \
    $${TOP}/src/DataRecorder.cpp \
    $${TOP}/src/NetworkStream.cpp \
    $${TOP}/src/Reference.cpp \
    $${TOP}/src/LogWidget.cpp \
    $${TOP}/src/PerformanceMonitor.cpp \
    $${TOP}/src/PerformanceMonitorWidget.cpp

HEADERS  += \
    $${TOP}/src/MainWindow.h\
    $${TOP}/src/utils.h \
    $${TOP}/src/FrameGrabber.h \
    $${TOP}/src/Camera.h \
    $${TOP}/src/ImageProcessor.h \
    $${TOP}/src/EyeImageProcessor.h \
    $${TOP}/src/pupil-detection/PupilDetectionMethod.h \
    $${TOP}/src/pupil-detection/ElSe.h \
    $${TOP}/src/pupil-detection/ExCuSe.h \
    $${TOP}/src/CameraWidget.h \
    $${TOP}/src/InputWidget.h \
    $${TOP}/src/FieldImageProcessor.h \
    $${TOP}/src/Synchronizer.h \
    $${TOP}/src/GazeEstimationWidget.h \
    $${TOP}/src/GazeEstimation.h \
    $${TOP}/src/gaze-estimation/GazeEstimationMethod.h \
    $${TOP}/src/gaze-estimation/PolyFit.h \
    $${TOP}/src/gaze-estimation/Homography.h \
    $${TOP}/src/DataRecorder.h \
    $${TOP}/src/NetworkStream.h \
    $${TOP}/src/Reference.h \
    $${TOP}/src/LogWidget.h \
    $${TOP}/src/PerformanceMonitor.h \
    $${TOP}/src/PerformanceMonitorWidget.h

FORMS    += \
    $${TOP}/src/MainWindow.ui \
    $${TOP}/src/CameraWidget.ui \
    $${TOP}/src/GazeEstimationWidget.ui \
    $${TOP}/src/LogWidget.ui \
    $${TOP}/src/PerformanceMonitorWidget.ui

RESOURCES += \
    $${TOP}/resources.qrc

INCLUDEPATH += "$${TOP}/src"

Debug:DBG_SUFFIX = "d"

# (sniyaz): You *may* to point this to your own OpenCV install. Try the instruction on the repo and see.
OPENCVPATH="/usr/local/"
INCLUDEPATH += $${OPENCVPATH}/include/
win32:contains(QMAKE_HOST.arch, x86_64) {
    LIBS += "-L$${OPENCVPATH}/x64/vc14/lib/"
} else {
    LIBS += "-L$${OPENCVPATH}/x86/vc14/lib/"
}
unix{
    LIBS += "-L$${OPENCVPATH}/lib/"
}
LIBS += \
    -lopencv_calib3d \
    -lopencv_core \
    -lopencv_highgui \
    -lopencv_imgcodecs \
    -lopencv_imgproc \
    -lopencv_videoio \
    -lopencv_aruco

# JPEG-TURBO
contains(DEFINES, TURBOJPEG) {
    # (sniyaz): You *may* need to point this to your own libjpeg-turbo install. Try the instructions on the repo and see.
    INCLUDEPATH += "/usr/local/include/"
    LIBS += "-L/usr/local/lib/"
    LIBS += -lturbojpeg
}

contains(DEFINES, STARBURST) {
    SOURCES += $${TOP}/pupil-detection/Starburst.cpp
    HEADERS += $${TOP}/pupil-detection/Starburst.h
}
contains(DEFINES, SWIRSKI) {
    SOURCES += $${TOP}/pupil-detection/Swirski.cpp
    HEADERS += $${TOP}/pupil-detection/Swirski.h

    TBB_INC_DIR = $${TOP}/deps/tbb43/include
    TBB_LIB_DIR = $${TOP}/deps/tbb43/lib/ia32/vc11
    INCLUDEPATH += "$${TBB_INC_DIR}"
    LIBS += "-L$${TBB_LIB_DIR}"
    LIBS += -ltbb
}

# Work around for bad visual studio update (msvc14)
win32{
    INCLUDEPATH += "C:/Program Files (x86)/Windows Kits/10/Include/10.0.10240.0/ucrt"
    contains(QMAKE_HOST.arch, x86_64) {
        LIBS += -L"C:/Program Files (x86)/Windows Kits/10/Lib/10.0.10240.0/ucrt/x64"
    } else {
        LIBS += -L"C:/Program Files (x86)/Windows Kits/10/Lib/10.0.10240.0/ucrt/x86"
    }
}

# Copy plugins
win32{
    copydata.commands = (robocopy $$PWD/deps/runtime/x64/Release/plugins $$OUT_PWD/plugins /E) ^& exit 0
    first.depends = $(first) copydata
    export(first.depends)
    export(copydata.commands)
    QMAKE_EXTRA_TARGETS += first copydata
}

system("git --version"):{
    GIT_VERSION=$$system(git --git-dir $${TOP}/../.git --work-tree $$TOP describe --always --tags)
    DEFINES += GIT_VERSION=\\\"$$GIT_VERSION\\\"
} else {
    GIT_VERSION=""
}
