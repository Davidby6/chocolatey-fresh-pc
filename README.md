# chocolatey-fresh-pc
A PS install script using Chocolatey for a fresh-pc install

1. Run powershell as Admin (right click -> run as administrator)
2. Allow executing scripts: set-executionpolicy remotesigned
3. Run the script main.ps1
    1. Run Install
    2. Run Update
    
* If you are installing a development framework that can have multiple versions installed such as .netcore-sdk, set the -m flag on
