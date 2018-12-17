# This Gentoo overlay provides
* ebuilds for multiple qtsdks
* ebuilds for new versions for qtcreator and kdevelop
* ebuilds for prusa slic3r edition
* and many other

# Multislot QtSdk for development
With multislot qtsdk you can compile and install multiple versions of qtsdk in your system and maintain them using beloved portage system

```bash
dev@navi /opt/qtsdk $ emerge qtsdk-linux-clang:5.12.0
dev@navi /opt/qtsdk $ emerge qtsdk-linux-clang:5.11.3
...

dev@navi /opt/qtsdk $ tree -L 1
.
├── qtsdk-linux-clang-5.10.1
├── qtsdk-linux-clang-5.11.3
├── qtsdk-linux-clang-5.12.0
├── qtsdk-linux-clang-5.6.3
├── qtsdk-linux-clang-5.9.7
├── qtsdk-linux-clang-dbg-5.10.1
├── qtsdk-linux-clang-dbg-5.11.3
├── qtsdk-linux-clang-dbg-5.12.0
├── qtsdk-linux-clang-dbg-5.6.3
├── qtsdk-linux-clang-dbg-5.9.7
├── qtsdk-linux-g++-5.10.1
├── qtsdk-linux-g++-5.11.3
├── qtsdk-linux-g++-5.12.0
├── qtsdk-linux-g++-5.6.3
├── qtsdk-linux-g++-5.9.7
├── qtsdk-linux-g++-dbg-5.10.1
├── qtsdk-linux-g++-dbg-5.11.3
├── qtsdk-linux-g++-dbg-5.12.0
├── qtsdk-linux-g++-dbg-5.6.3
└── qtsdk-linux-g++-dbg-5.9.7
```


# Qt + Android = <3
Experimental support for qtsdk for android 
```bash
dev@navi /opt/qtsdk $ emerge qtsdk-android-clang
```
