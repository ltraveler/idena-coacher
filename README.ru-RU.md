<h1 align="center">
  <img width="350px" alt="Idena Coacher — монитор ноды Идена" Title="IDENA Coacher Monitor Tool" src="https://raw.githubusercontent.com/ltraveler/ltraveler/main/images/idena_coacher.png"><br/>
  Idena Coacher — монитор ноды Идена
</h1>
<p align="center">🖥️ Менеджер управления нодой Идена ✧ <b><i>Статус</i></b> ✧ <b>Вкл/Выкл <i>майнинга</i></b> ✧ <b><i>Импорт приватного ключа</i></b><br>Назначение утилиты — обеспечить удобный интерфейс навигации для выполнения базовых задач мониторинга статуса вашей удалённой ноды, с рядом возможностей по её управлению, без необходимости запуска десктопного клиента с включённой функцией перенаправления портов. </p>

<p align="center"><a href="https://github.com/ltraveler/idena-runner/releases/latest" target="_blank"><img src="https://img.shields.io/badge/version-v0.1.6-blue?style=for-the-badge&logo=none" alt="idena runner latest version" /></a>&nbsp;<a href="https://wiki.ubuntu.com/FocalFossa/ReleaseNotes" target="_blank"><img src="https://img.shields.io/badge/Kali-20.04(LTS)+-00ADD8?style=for-the-badge&logo=none" alt="Kali minimum version" /></a>&nbsp;<a href="https://github.com/ltraveler/idena-runner/blob/main/CHANGELOG.md" target="_blank"><img src="https://img.shields.io/badge/Build-Stable-success?style=for-the-badge&logo=none" alt="idena-go latest release" /></a>&nbsp;<a href="https://www.gnu.org/licenses/quick-guide-gplv3.html" target="_blank"><img src="https://img.shields.io/badge/license-GPL3.0-red?style=for-the-badge&logo=none" alt="license" /></a>&nbsp;<a href="https://github.com/ltraveler/idena-coacher/blob/main/README.md" target="_blank"><img src="https://img.shields.io/badge/readme-ENGLISH-orange?style=for-the-badge&logo=none" alt="Скрипт Idena Coacher" /></a></p>

<p align="center"><br>
  <img alt="Идена Кучер: монитор ноды" Title="Идена Кучер - основной интерфейс" src="https://raw.githubusercontent.com/ltraveler/ltraveler/main/images/IDENA_Coacher_Monitor_Tool_UI.jpg">
</p>

## 🚀&nbsp; Быстрый старт
*1. Клонируем репозиторий Idena Coacher в **домашнюю директорию пользователя** от имени которого происходит запуск ноды.*
```
cd /home/%username%
git clone https://github.com/ltraveler/idena-coacher.git
cd idena-coacher
```
*%username% - имя пользователя<br><br>
*2. Делаем файл idena_coacher.sh исполняемым*
```
chmod +x idena_coacher.sh
```
*3. Изначально IDENA Coacher был разработан как дополнительная утилита текстового интерфейса пользователя (TUI) для скриптов  [IDENA ARMer](https://github.com/ltraveler/idena-armer) и [IDENA Runner](https://github.com/ltraveler/idena-runner). Вы можете пропустить этот шаг если собираетесь использовать скрипт в связке с этими утилитами.<br><br>
В случае если ваша нода была установлена с помощью стороннего скрипта, вам потребуется изменить пути по умолчанию в основном файле скрипта `idena_coacher.sh`.<br><br>
Пожалуйста введите команду `nano idena_coacher.sh` в домашней директории скрипта и измените нижеследующие строки:*
```
PRIVATE_PATH="/home/$username/idena-go/datadir/keystore/nodekey"
```
*Строка №7:* **Путь к файлу приватного ключа `nodekey`**
```
API_PATH="/home/$username/idena-go/datadir/api.key"
```
*Строка №9:* **Путь к файлу API ключа ноды `api.key`**
```
LOG_PATH="/home/$username/idena-go/idena_screen.log"
```
*Строка №10:* **Путь к файлу логов клиента ноды idena-go**
```
export RPC_PORT="9009"
```
*Строка №12:* **Порт RPC вашей ноды (9009 - значение по умолчанию)**

*4. Run the script.*
```
./idena_coacher.sh
```
