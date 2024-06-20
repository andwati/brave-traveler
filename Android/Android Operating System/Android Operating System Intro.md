The foundation of the [Android platform](https://getstream.io/chat/sdk/android/) is the [Linux kernel](https://www.redhat.com/en/topics/linux/what-is-the-linux-kernel), which allows Android to take advantage of certain security features. The Linux kernel has been used in millions of security-sensitive systems since its creation in 1991, so it has a long history of consistently being researched, tested, and improved upon by thousands of developers.

According to [the Android docs](https://source.android.com/security/overview/kernel-security.html), Android utilizes several key Linux security features including:

-  user-based permissions mode
- Process isolation
- An extensible mechanism for secure inter-process communication (IPC)
- The ability to remove unnecessary and/or insecure parts of the kernel

Another key feature of Linux is its multiuser operating system, which allows multiple users to access independent system resources such as memory, CPU resources, RAM, and applications. By isolating user resources from one another, they can be protected from each other.

The Android platform takes advantage of the Linux multiuser system with its own [Application Sandbox](https://source.android.com/security/overview/kernel-security.html#the-application-sandbox), which isolates app resources from each other and protects apps and the system from malicious apps. For more details, check out [Application Sandbox](https://source.android.com/security/app-sandbox).