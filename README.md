This is an upgrade helper tool for Windows 10/11 and Windows Server.

This is a Chinese-compiled version based on the "[In-Place_Upgrade_Helper]" project with modifications.

This tool can upgrade Windows via four different methods:

- Changing the product key via `slmgr`. This method only supports [the official upgrade paths][1].

- Starting `Setup.exe` and letting it choose the edition by itself. This is an ordinary in-place upgrade.

- Starting an in-place upgrade of a Windows edition of your choice. This method stops Windows Setup from using any firmware-embedded keys or your current edition. This is done by using an OEM GLVK key as a setup parameter. This method only supports [the official upgrade paths][1].

- Starting a forced in-place upgrade to keep all apps and settings. This method modifies the Windows Registry before using OEM GLVK keys, enabling an edition change outside the supported upgrade path, e.g., "Pro" to "Home," "Education Pro" or "Enterprise," or "Education" to "IoT Enterprise LTSC". Microsoft does not endorse this method. Use this method at your own risk. Please back up your system in advance.

Copy this tool to your installation media alongside `setup.exe` and run it. Or start it by itself and enter the path of your installation files.
External installation files, like a mounted or extracted ISO, are supported.

![IUH3](https://github.com/pyCharmikun1/In-Place_Upgrade_Helper_Chinese/blob/main/1.png)
![IUH1](https://github.com/pyCharmikun1/In-Place_Upgrade_Helper_Chinese/blob/main/2.png)
![IUH2](https://github.com/pyCharmikun1/In-Place_Upgrade_Helper_Chinese/blob/main/3.png)

Please note:

- This tool is a work in progress.
- This tool **DOES NOT** activate Windows. Any product keys it uses are placeholder OEM GVLK keys.
- This tool has been compiled in Chinese.

[1]: https://learn.microsoft.com/en-us/windows/deployment/upgrade/windows-edition-upgrades
[In-Place_Upgrade_Helper]: https://github.com/TheMMC/In-Place_Upgrade_Helper/tree/main