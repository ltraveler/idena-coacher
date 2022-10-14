<h1 align="center">
  <img width="350px" alt="Idena Coacher Node Monitor Tool" Title="IDENA Coacher - Node Monitor Tool" src="https://raw.githubusercontent.com/ltraveler/ltraveler/main/images/idena_coacher.png"><br/>
  Idena Coacher — Node Monitor Tool
</h1>
<p align="center">🖥️ Bash implementation of the localhost idena node monitor ✧ <b><i>Status</i></b> ✧ <b><i>Mining</i> ON/OFF</b> ✧ <b><i>Key change</i></b><br>The purpose of this tool is to locally manage your idena node without having to run Idena Desktop client with enabled port forwarding. </p>

<p align="center"><a href="https://github.com/ltraveler/idena-runner/releases/latest" target="_blank"><img src="https://img.shields.io/badge/version-v0.1.0-blue?style=for-the-badge&logo=none" alt="idena runner latest version" /></a>&nbsp;<a href="https://wiki.ubuntu.com/FocalFossa/ReleaseNotes" target="_blank"><img src="https://img.shields.io/badge/Kali-20.04(LTS)+-00ADD8?style=for-the-badge&logo=none" alt="Kali minimum version" /></a>&nbsp;<a href="https://github.com/ltraveler/idena-runner/blob/main/CHANGELOG.md" target="_blank"><img src="https://img.shields.io/badge/Build-Stable-success?style=for-the-badge&logo=none" alt="idena-go latest release" /></a>&nbsp;<a href="https://www.gnu.org/licenses/quick-guide-gplv3.html" target="_blank"><img src="https://img.shields.io/badge/license-GPL3.0-red?style=for-the-badge&logo=none" alt="license" /></a>&nbsp;<a href="https://github.com/ltraveler/idena-coacher/blob/master/README.md" target="_blank"><img src="https://img.shields.io/badge/readme-РУССКИЙ-orange?style=for-the-badge&logo=none" alt="Скрипт Idena ARMer" /></a></p>

<p align="center"><br>
  <img alt="Idena Coacher Node Monitor Tool" Title="IDENA Coacher - User Interface" src="https://raw.githubusercontent.com/ltraveler/ltraveler/main/images/IDENA_Coacher_Monitor_Tool_UI.jpg">
</p>

## 🚀&nbsp; Quick Start
*1. Clone Idena Coacher to the **home directory of the user** that runs idena-go node client.*
```
cd /home/%username%
git clone https://github.com/ltraveler/idena-coacher.git
cd idena-coacher
```
*2. Make idena_coacher.sh executable*
```
chmod +x idena_coacher.sh
```
*3. Originally IDENA Coacher has been developed as an additional TUI tool to manage nodes that have been deployed by [IDENA ARMer](https://github.com/ltraveler/idena-armer) or [IDENA Runner](https://github.com/ltraveler/idena-runner) scripts.<br><br>
That's not to say that it couldn't be used with the node that has been set customly. In case if you are using a custom node you would have to change the default paths in the main script file.<br><br>
To edit `idena_coacher.sh` simply run the command `nano idena_coacher.sh` in the home folder of the script and edit the following lines:*
```
PRIVATE_PATH="/home/$username/idena-go/datadir/keystore/nodekey"
```
*Line #7:* **Path to the nodekey (private key) file**
```
API_PATH="/home/$username/idena-go/datadir/api.key"
```
*Line #9:* **Path to the node api.key file**
```
LOG_PATH="/home/$username/idena-go/idena_screen.log"
```
*Line #10:* **Path to the idena-go log file**
```
export RPC_PORT="9009"
```
*Line #12:* **RPC Port of your node**

*4. Run the script.*
```
./idena_coacher.sh
```
