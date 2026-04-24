# libTAS-wsl
Generate custom WSL distributions with [libTAS](https://github.com/clementgallet/libTAS) preinstalled.
After installing WSL, Windows users can simply download one of the files from
[the latest release](https://github.com/StephenCWills/libTAS-wsl/releases/latest)
and double-click the file to install libTAS.

# Prerequisites
The distributions produced by libTAS-wsl require an internet connection.

If you have not already installed WSL, open a command prompt and run the following command.
After running the command, you will likely need to reboot your computer.

```
wsl --install --no-distribution
```

If you encounter any issues installing WSL, please refer to Microsoft's documentation
for more details.

https://learn.microsoft.com/en-us/windows/wsl/install

# Installation
Go to [the latest release](https://github.com/StephenCWills/libTAS-wsl/releases/latest)
page, scroll to the bottom, and download one of the files with the `.wsl` file extension.
Double-click the file to begin the installation process. After that simply follow the
on-screen instructions to complete the installation. At the end of the installation,
you should see a Linux terminal prompt ending in `$`. From here, you can run libTAS by
simply entering `libTAS` into the prompt.

The installation creates a WSL distribution called `libTAS`. If you close the terminal,
you should be able to open it back up again by searching for `libTAS` in your Start menu.

_**Note**: The installation process may ask you about your geographic region and time zone.
           This occurs as part of the setup for the `tzdata` package, which is a dependency
           of several other packages on Linux systems. This setup is similar to changing your
           time zone settings on Windows OS to make your clock display the correct time of
           day. This information is not critical, and it does not need to be accurate in
           order for libTAS to function. If you are uncomfortable sharing your personal
           information, feel free to enter any value you like._

## Interim
In addition to the releases, this project also offers a distribution containing [the
latest interim version](https://github.com/StephenCWills/libTAS-wsl/releases/interim)
of libTAS alongside both PCem and Ruffle. This distribution is refreshed nightly by
compiling the applications from source. It can be installed the same way as any of the
release versions by downloading the `libTAS-interim_amd64.wsl` file and double-clicking
it to begin the installation process.

## Uninstall
Should you need to uninstall your libTAS distribution, you must do so by issuing the
unregister command to WSL. Open a command prompt and enter the following command.

```
wsl --unregister libTAS
```

Keep in mind that each installed instance of a WSL distribution is effectively an
installation of a Linux-based operating system with its own directory structure and
files. If you have installed any games on your WSL distribution in order to TAS them,
unregistering the distribution will delete the game along with it. Furthermore, any
TAS movies you have created will be lost if they are not copied to your Windows drive
first. You can use Windows Explorer to navigate the Linux filesystem and copy any
files you need before uninstalling.

## Advanced
By default, the libTAS-wsl distributions will create a WSL distribution called `libTAS`.
Normally this means multiple versions cannot be installed side-by-side. However, instead
of double-clicking, the `*.wsl` file can also be installed using the `wsl` command in the
command prompt. You can assign a different name using the `--name` parameter.

```
wsl --install --name libTAS-1.4.7 --from-file libTAS-1.4.7_amd64.wsl
```
