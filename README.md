# This Gentoo overlay provides
* Multiple Qt SDKs
* Latest Qt Creator and KDevelop
* Latest PrusaSlicer
* Personal projects
* and many other

## Qt SDK - example of multiple installations

```bash
larry@gentoo /opt/qtsdk $ emerge qtsdk-linux-clang:5.13.1
larry@gentoo /opt/qtsdk $ emerge qtsdk-linux-clang:5.12.5

larry@gentoo $ tree -L 1 -f /opt/qtsdk
.
├── /opt/qtsdk/qtsdk-linux-g++-5.13.1
├── /opt/qtsdk/qtsdk-linux-g++-5.12.5
├── /opt/qtsdk/qtsdk-linux-clang-5.13.1
├── /opt/qtsdk/qtsdk-linux-clang-5.12.5
```

## Qt SDK for Android
Experimental support for Qt SDK for Android

```bash
larry@gentoo /opt/qtsdk $ emerge qtsdk-android-clang:5.14.0
```
