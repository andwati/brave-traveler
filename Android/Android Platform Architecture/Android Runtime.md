[Android Runtime](https://source.android.com/devices/tech/dalvik/index.html) (ART) is an application [Runtime System](https://en.wikipedia.org/wiki/Runtime_system) used by Android OS and one of the core features in the Android ecosystem. ART was invented to replace the [Dalvik virtual machine](https://en.wikipedia.org/wiki/Dalvik_(software)) for devices running Android version 5.0 (L​ollipop) or higher.

The main role of ART is to execute the [Dalvik Executable format](https://source.android.com/devices/tech/dalvik/dex-format) (DEX) by translating DEX bytecode into machine code that your system can understand.

ART architecture was written to run multiple virtual machines on low-memory devices. Some key features are directly related to the speed of running the Android applications. Key features of ART include:

- Ahead-of-time (AOT) and just-in-time (JIT) compilation
- Enhanced garbage collection (GC)
- [Converting an app package's DEX files to condensed machine code](https://developer.android.com/about/versions/pie/android-9.0#art-aot-dex) (on Android 9 (API level 28+))
- Better debugging support, including detailed diagnostics and crash reporting, the ability to set multiple watchpoints, and more

For more details, check out [Android Runtime (ART) and Dalvik](https://source.android.com/devices/tech/dalvik/index.html).