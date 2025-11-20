# libTAS-wsl
Generate custom WSL distributions with libTAS preinstalled.
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

## Advanced
By default, the libTAS-wsl distributions will create a WSL distribution called `libTAS`.
This means multiple versions cannot be installed side-by-side. However, the file can also
be installed using the `wsl` command in the command prompt. You can assign a different
name using the `--name` parameter.

```
wsl --install --name libTAS-1.4.7 --from-file libTAS-1.4.7_amd64.wsl
```
