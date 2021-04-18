# This Gentoo overlay provides
* Multiple Qt SDKs
* Qt Creator and KDevelop
* PrusaSlicer
* Personal projects
* and many other

## Qt SDK - example of multiple installations

```bash
larry@gentoo /opt/qtsdk $ emerge qtsdk-linux-clang:5.15.2
larry@gentoo /opt/qtsdk $ emerge qtsdk-linux-clang:5.12.10

larry@gentoo $ tree -L 1 -f /opt/qtsdk
.
├── /opt/qtsdk/qtsdk-linux-g++-5.15.2
├── /opt/qtsdk/qtsdk-linux-g++-5.12.10
├── /opt/qtsdk/qtsdk-linux-clang-5.15.2
├── /opt/qtsdk/qtsdk-linux-clang-5.12.10
```

## Qt SDK for Android
Experimental support for Qt SDK for Android

```bash
larry@gentoo /opt/qtsdk $ emerge qtsdk-android-clang:5.15.2
```
