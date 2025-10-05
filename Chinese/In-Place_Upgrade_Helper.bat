@echo off

Rem »ñÈ¡¹ÜÀíÔ±È¨ÏÞ
>nul 2>&1 fsutil dirty query %systemdrive% && (goto gotAdmin) || (goto UACPrompt)
:UACPrompt
if exist "%SYSTEMROOT%\System32\Cscript.exe" (
    echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "%~s0", "", "", "runas", 1 > "%temp%\getadmin.vbs"
    cscript //nologo "%temp%\getadmin.vbs"
    exit /b
) else (
    powershell -Command "Start-Process -Verb RunAs -FilePath '%~s0'"
    exit /b
)
:gotAdmin
if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs"
pushd "%CD%" && CD /D "%~dp0"

if not defined iammaximized (
    set iammaximized=1
    start /max "" "%0" "%*"
    exit
)

cls
echo Èç¹û´Ë´°¿ÚÎ´×î´ó»¯£¬ÇëÊÖ¶¯µ÷Õû´óÐ¡¡£
echo ÕâÊÇ Windows ÖÕ¶ËµÄÒ»¸öÒÑÖªÎÊÌâ¡£
echo.
SETLOCAL
Rem ×Ô¶¯¼ÓÔØÏµÍ³±äÁ¿
for /f "tokens=2*" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName') do set productname=%%j
for /f "tokens=2*" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v EditionID') do set editionid=%%j
for /f "tokens=2*" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CompositionEditionID') do set compositioneditionid=%%j
Rem ¼ì²é±äÁ¿ÊÇ·ñÉèÖÃ£¬ÈçÎ´ÉèÖÃÔòÊ¹ÓÃÄ¬ÈÏÖµ
if "%productname%"=="" set productname=Windows 10 Pro
if "%editionid%"=="" set editionid=Professional
if "%compositioneditionid%"=="" set compositioneditionid=Enterprise

set "choice="
set sourcespath=.

:premainmenu
if not exist "%sourcespath%"\setup.exe goto nosetupfound
if not exist "%sourcespath%"\sources\ goto nosetupfound
echo ÕÒµ½°²×°ÎÄ¼þ
echo.
echo Èç¹ûËùÑ¡°æ±¾ÔÚ°²×°½éÖÊÉÏ²»¿ÉÓÃ£¬Windows °²×°³ÌÐò¿ÉÒÔ×ÔÐÐÉú³ÉÄ³Ð©°æ±¾¡£
echo Éý¼¶Í¼±í£º
echo.
echo ¿É°²×°°æ±¾                     °²×°½éÖÊÉÏÐèÒªµÄ°æ±¾
echo.
echo Windows Pro                                   Windows Pro
echo Windows Pro for Workstations                  Windows Pro
echo Windows Education                             Windows Pro
echo Windows Pro Education                         Windows Pro
echo Windows Enterprise                            Windows Pro
echo Windows Enterprise multi-session              Windows Pro
echo Windows IoT Enterprise                        Windows Pro
echo Windows SE [Cloud] (½öWin11)                  Windows Pro
echo Windows Home                                  Windows Home
echo Windows Home Single Language                  Windows Home
echo Windows Pro N                                 Windows Pro N
echo Windows Pro N for Workstations                Windows Pro N
echo Windows Education N                           Windows Pro N
echo Windows Pro Education N                       Windows Pro N
echo Windows Enterprise N                          Windows Pro N
echo Windows SE [Cloud] N (½öWin11)                Windows Pro N
echo Windows 10 Enterprise LTSC 2021               Windows 10 Enterprise LTSC 2021
echo Windows 10 Enterprise N LTSC 2021             Windows 10 Enterprise LTSC N 2021
echo Windows 10 IoT Enterprise LTSC 2021           Windows 10 Enterprise LTSC 2021
echo Windows 11 Enterprise LTSC 2024               Windows 11 Enterprise LTSC 2024
echo Windows 11 Enterprise N LTSC 2024             Windows 11 Enterprise N LTSC 2024
echo Windows 11 IoT Enterprise LTSC 2024           Windows 11 Enterprise LTSC 2024
echo Windows 11 IoT Enterprise LTSC Subscr. 2024   Windows 11 Enterprise LTSC 2024
echo Windows Server 2022 Standard                  Windows Server 2022 Standard
echo Windows Server 2022 Datacenter                Windows Server 2022 Datacenter
echo Windows Server 2025 Standard                  Windows Server 2025 Standard
echo Windows Server 2025 Datacenter                Windows Server 2025 Datacenter

echo.
echo °´ÈÎÒâ¼üÁÐ³ö°²×°½éÖÊÉÏµÄ¿ÉÓÃ°æ±¾¡£
pause>nul|set/p=&echo(
echo ÕýÔÚ¶ÁÈ¡°²×°½éÖÊ£¬ÇëÉÔºò...
if exist "%sourcespath%\sources\install.wim" powershell -ExecutionPolicy Bypass -Command "Get-WindowsImage -ImagePath '%sourcespath%\sources\install.wim' | Select-Object -Property ImageName, ImageIndex"
if exist "%sourcespath%\sources\install.esd" powershell -ExecutionPolicy Bypass -Command "Get-WindowsImage -ImagePath '%sourcespath%\sources\install.esd' | Select-Object -Property ImageName, ImageIndex"
if exist "%sourcespath%\sources\install.swm" powershell -ExecutionPolicy Bypass -Command "Get-WindowsImage -ImagePath '%sourcespath%\sources\install.swm' | Select-Object -Property ImageName, ImageIndex"
echo °´ÈÎÒâ¼üÆô¶¯¾ÍµØÉý¼¶ÖúÊÖ¡£
pause>nul|set/p=&echo(


:mainmenu
cls
ECHO M-M-C ¿ìËÙ¾ÍµØÉý¼¶ÖúÊÖ for Win10/11
echo V0.93
echo.
echo ÊäÈëËùÐè°æ±¾µÄ±àºÅ£¬°´»Ø³µ£¬Ñ¡ÔñÉý¼¶·½·¨£¬È»ºóÔÙ´Î°´»Ø³µ¡£
echo.
if "%productkey%"=="" echo ²úÆ·Ãû³Æ: [92m%productname%[0m [93m(´Ó×¢²á±í¶ÁÈ¡)[0m
if not "%productkey%"=="" echo ²úÆ·Ãû³Æ: [92m%productname%[0m
echo (×¢²á±í¼üÖµ×ÜÊÇÏÔÊ¾"Windows 10"£¬¼´Ê¹°²×°ÁË Windows 11)
echo °æ±¾ID: [92m%editionid%[0m
if "%productkey%"=="" echo OEM²úÆ·ÃÜÔ¿: [93mÎ´Ñ¡Ôñ°æ±¾[0m
if not "%productkey%"=="" echo OEM²úÆ·ÃÜÔ¿: [92m%productkey%[0m
echo (Î¢Èí¹Ù·½Ô¤°²×°ÃÜÔ¿£¬²»ÓÃÓÚ¼¤»î)
echo ×éºÏ°æ±¾ID: [92m%compositioneditionid%[0m
echo (»ù´¡°æ±¾£¬Êµ¼Ê°æ±¾ÔÚ¼¼ÊõÉÏ»ùÓÚ´Ë°æ±¾ÅÉÉú)
echo.
echo ±ê×¼°æ±¾£º
echo 1) Windows ¼ÒÍ¥°æ                       10) Windows 11 SE ÔÆ°æ±¾
echo 2) Windows ×¨Òµ°æ                       11) Windows ¼ÒÍ¥°æ N
echo 3) Windows ×¨Òµ¹¤×÷Õ¾°æ                 12) Windows ×¨Òµ°æ N
echo 4) Windows ÆóÒµ°æ                       13) Windows ×¨Òµ¹¤×÷Õ¾°æ N
echo 5) Windows ×¨Òµ½ÌÓý°æ                   14) Windows ×¨Òµ½ÌÓý°æ N
echo 6) Windows ½ÌÓý°æ                       15) Windows ½ÌÓý°æ N
echo 7) Windows ÆóÒµ°æ¶à»á»°                 16) Windows ÆóÒµ°æ N
echo 8) Windows IoT ÆóÒµ°æ                   17) Windows 11 SE ÔÆ°æ±¾ N
echo 9) Windows ¼ÒÍ¥µ¥ÓïÑÔ°æ
echo LTSC³¤ÆÚ·þÎñ°æ£º
echo 18) Windows 10 ÆóÒµ°æ LTSC 2021         22) Windows 11 IoT ÆóÒµ°æ LTSC 2024
echo 19) Windows 10 IoT ÆóÒµ°æ LTSC 2021     23) Windows 11 ÆóÒµ°æ N LTSC 2024
echo 20) Windows 10 ÆóÒµ°æ N LTSC 2021       24) Windows 11 IoT ÆóÒµ°æ LTSC ¶©ÔÄ°æ 2024
echo 21) Windows 11 ÆóÒµ°æ LTSC 2024
echo ·þÎñÆ÷°æ±¾£º
echo 25) Windows Server 2022 ±ê×¼°æ          27) Windows Server 2025 ±ê×¼°æ
echo 26) Windows Server 2022 Êý¾ÝÖÐÐÄ°æ      28) Windows Server 2025 Êý¾ÝÖÐÐÄ°æ
echo.
echo k) ·½·¨ 1 - ³¢ÊÔÊ¹ÓÃ slmgr °²×°ËùÑ¡ÃÜÔ¿£¨¼òµ¥°æ±¾¸ü¸Ä£¬ÎÞÐè¾ÍµØÉý¼¶£©
echo s) ·½·¨ 2 - ¿ªÊ¼Éý¼¶¶ø²»Ñ¡Ôñ°æ±¾£¬ÓÉ°²×°³ÌÐò×ÔÐÐ¾ö¶¨¡£µÈÍ¬ÓÚÕý³£µÄ¾ÍµØÉý¼¶
echo u) ·½·¨ 3 - ¿ªÊ¼Éý¼¶µ½ËùÑ¡°æ±¾¡£Ê¹ÓÃÏàÓ¦µÄÔ¤°²×°ÃÜÔ¿½øÐÐ°²×°
echo f) ·½·¨ 4 - ¿ªÊ¼Ç¿ÖÆÉý¼¶µ½ËùÑ¡°æ±¾¡£Ê¹ÓÃÏàÓ¦µÄÔ¤°²×°ÃÜÔ¿½øÐÐ°²×°
echo.
echo 0) ÍË³ö

set "choice="
set /p choice=ÇëÑ¡Ôñ£º 
if '%choice%'=='1' goto setvarcore
if '%choice%'=='2' goto setvarpro
if '%choice%'=='3' goto setvarpfw
if '%choice%'=='4' goto setvarent
if '%choice%'=='5' goto setvarproed
if '%choice%'=='6' goto setvared
if '%choice%'=='7' goto setvarentmulti
if '%choice%'=='8' goto setvariotent
if '%choice%'=='9' goto setvarcoresl
if '%choice%'=='10' goto setvarcloud
if '%choice%'=='11' goto setvarcoren
if '%choice%'=='12' goto setvarpron
if '%choice%'=='13' goto setvarpfwn
if '%choice%'=='14' goto setvarproedn
if '%choice%'=='15' goto setvaredn
if '%choice%'=='16' goto setvarentn
if '%choice%'=='17' goto setvarcloudn
if '%choice%'=='18' goto setvarltsc2021
if '%choice%'=='19' goto setvariotltsc2021
if '%choice%'=='20' goto setvarltscn2021
if '%choice%'=='21' goto setvarltsc2024
if '%choice%'=='22' goto setvariotltsc2024
if '%choice%'=='23' goto setvarltscn2024
if '%choice%'=='24' goto setvariotltscsub2024
if '%choice%'=='25' goto setvarserv22std
if '%choice%'=='26' goto setvarserv22data
if '%choice%'=='27' goto setvarserv25std
if '%choice%'=='28' goto setvarserv25data
if '%choice%'=='u' goto runupgrade
if '%choice%'=='U' goto runupgrade
if '%choice%'=='k' goto keychange
if '%choice%'=='K' goto keychange
if '%choice%'=='s' goto runboringupgrade
if '%choice%'=='S' goto runboringupgrade
if '%choice%'=='f' goto runforcedupgrade
if '%choice%'=='F' goto runforcedupgrade
if '%choice%'=='0' goto endofbatch
ECHO.
ECHO Î´ÕÒµ½"%choice%"£¬°´ÈÎÒâ¼üÖØÊÔ¡£&ECHO. &pause>nul|set/p=&echo(
ECHO.
goto mainmenu

:keychange
if "%productkey%"=="" goto nokeyselected
echo ³¢ÊÔÍ¨¹ý¼òµ¥¸ü¸ÄÃÜÔ¿À´¸ü¸Ä°æ±¾...
slmgr /ipk %productkey%
goto mainmenu

:runboringupgrade
echo.
echo °²×°³ÌÐòºÍºóÌ¨½ø³ÌÕýÔÚÔËÐÐ£¬ÇëÉÔºò¡£´Ë´°¿Ú½«×Ô¶¯¹Ø±Õ¡£
%sourcespath%\setup.exe /eula accept /telemetry disable /priority normal /resizerecoverypartition enable
goto endofbatch

:runupgrade
if "%productkey%"=="" goto nokeyselected
echo.
echo °²×°³ÌÐòºÍºóÌ¨½ø³ÌÕýÔÚÔËÐÐ£¬ÇëÉÔºò¡£´Ë´°¿Ú½«×Ô¶¯¹Ø±Õ¡£
%sourcespath%\setup.exe /eula accept /telemetry disable /priority normal /resizerecoverypartition enable /pkey %productkey%
goto endofbatch

:runforcedupgrade
if "%productkey%"=="" goto nokeyselected
echo.
echo Í¨¹ý"Î±Ôì"×¢²á±íÖÐµÄ²»Í¬°æ±¾£¬Ç¿ÖÆ½øÐÐ¾ÍµØÉý¼¶£¨±£ÁôÓ¦ÓÃºÍÉèÖÃ£©µ½ËùÑ¡°æ±¾¡£
echo ÀýÈç£¬Èç¹ûÒª°²×°×¨Òµ°æ£¬Ôò×¢²á±íÖÐµÄ"ProductName"ºÍ"EditionID"½«±»×¨Òµ°æµÄÖµ¸²¸Ç¡£
echo °²×°³ÌÐò»áÈÏÎª×¨Òµ°æÒÑ°²×°£¬²¢¼ÌÐøÖ´ÐÐ¾ÍµØÉý¼¶¡£
echo ÕâÑù¾Í¿ÉÒÔÖ´ÐÐ²»ÔÚ¹Ù·½Éý¼¶Â·¾¶ÖÐµÄ¾ÍµØÉý¼¶£¬ÀýÈç´Ó×¨Òµ°æ½µ¼¶µ½¼ÒÍ¥°æ¡£
echo ÉõÖÁ¿ÉÒÔ½âËøÒòÐí¿ÉÔ­Òò¶ø×èÖ¹µÄÉý¼¶Â·¾¶£¬ÀýÈç´Ó¼ÒÍ¥°æÖ±½ÓÉý¼¶µ½ÆóÒµ°æ¡£
echo »òÕß¸ü´´ÐÂµÄ²Ù×÷£¬Èç Win10 ½ÌÓý°æÉý¼¶µ½ Win10 IoT ÆóÒµ°æ LTSC Ò²ÊÇ¿ÉÄÜµÄ¡£
echo.
echo Õâµ±È»ÍêÈ«²»ÊÜÎ¢ÈíÖ§³Ö£¬Çë×ÔÐÐ³Ðµ£Ê¹ÓÃ·çÏÕ¡£
echo µ«ÊÇ£¬µ½Ä¿Ç°ÎªÖ¹ÉÐÎ´³öÏÖÎÊÌâ£¬ËùÓÐÐÐÎª¶¼ÏñÕý³£µÄ¾ÍµØÉý¼¶Ò»Ñù¡£
echo Èç¹û²»Ð¡ÐÄ½«´íÎóµÄ°æ±¾Ð´Èë×¢²á±í£¬Ö»ÐèÊ¹ÓÃÕýÈ·µÄ°æ±¾ÖØÐÂÆô¶¯Ç¿ÖÆ¾ÍµØÉý¼¶¼´¿É¡£
echo.
echo È·¶¨Òª¼ÌÐøÂð£¿·ñÔòÇëÁ¢¼´¹Ø±Õ´Ë´°¿Ú£¡
echo.
pause>nul|set/p=°´ÈÎÒâ¼ü¼ÌÐø¡£&echo(
echo.
echo ÕýÔÚÉèÖÃ×¢²á±íÏî...
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "EditionID" /t REG_SZ /d "%editionid%" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "ProductName" /t REG_SZ /d "%productname%" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "CompositionEditionID" /t REG_SZ /d "%compositioneditionid%" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion" /v "EditionID" /t REG_SZ /d "%editionid%" /f /reg:32
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion" /v "ProductName" /t REG_SZ /d "%productname%" /f /reg:32
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion" /v "CompositionEditionID" /t REG_SZ /d "%compositioneditionid%" /f /reg:32
echo.
echo °²×°³ÌÐòºÍºóÌ¨½ø³ÌÕýÔÚÔËÐÐ£¬ÇëÉÔºò¡£´Ë´°¿Ú½«×Ô¶¯¹Ø±Õ¡£
%sourcespath%\setup.exe /eula accept /telemetry disable /priority normal /resizerecoverypartition enable /pkey %productkey%
goto endofbatch

:nosetupfound
echo Î´ÕÒµ½ Setup.exe ºÍ/»ò Sources ÎÄ¼þ¼Ð£¡Î´½«¹¤¾ß¸´ÖÆµ½°²×°ÎÄ¼þ£¿
echo ³¢ÊÔÊ¹ÓÃÍâ²¿°²×°½éÖÊ...
set /p sourcespath=ÇëÊäÈë°²×°½éÖÊµÄÂ·¾¶£¨ÀýÈç F:\ »ò D:\unpackedISO\£©£º 
goto premainmenu

:nokeyselected
echo ÇëÏÈÑ¡Ôñ Windows °æ±¾£¡
echo.
pause>nul|set/p=°´ÈÎÒâ¼ü¼ÌÐø¡£&echo(
goto mainmenu

Rem ´Ë´¦¶¨Òå²»Í¬µÄ Windows °æ±¾

Rem Windows ¼ÒÍ¥°æ
:setvarcore
set productkey=YTMG3-N6DKC-DKB77-7M9GH-8HVX7
set editionid=Core
set productname=Windows 10 Home
set compositioneditionid=Core
goto mainmenu

Rem Windows ×¨Òµ°æ
:setvarpro
set productkey=VK7JG-NPHTM-C97JM-9MPGT-3V66T
set editionid=Professional
set productname=Windows 10 Pro
set compositioneditionid=Enterprise
goto mainmenu

Rem Windows ×¨Òµ¹¤×÷Õ¾°æ
:setvarpfw
set productkey=DXG7C-N36C4-C4HTG-X4T3X-2YV77
set editionid=ProfessionalWorkstation
set productname=Windows 10 Pro for Workstations
set compositioneditionid=Enterprise
goto mainmenu

Rem Windows ÆóÒµ°æ
:setvarent
set productkey=XGVPP-NMH47-7TTHJ-W3FW7-8HV2C
set editionid=Enterprise
set productname=Windows 10 Enterprise
set compositioneditionid=Enterprise
goto mainmenu

Rem Windows ×¨Òµ½ÌÓý°æ
:setvarproed
set productkey=8PTT6-RNW4C-6V7J2-C2D3X-MHBPB
set editionid=ProfessionalEducation
set productname=Windows 10 Pro Education
set compositioneditionid=Enterprise
goto mainmenu

Rem Windows ½ÌÓý°æ
:setvared
set productkey=YNMGQ-8RYV3-4PGQ3-C8XTP-7CFBY
set editionid=Education
set productname=Windows 10 Education
set compositioneditionid=Enterprise
goto mainmenu

Rem Windows ÆóÒµ°æ¶à»á»°/ÐéÄâ×ÀÃæ
:setvarentmulti
set productkey=CPWHC-NT2C7-VYW78-DHDB2-PG3GK
set editionid=ServerRdsh
set productname=Windows 10 Enterprise multi-session
set compositioneditionid=Enterprise
goto mainmenu

Rem Windows IoT ÆóÒµ°æ
:setvariotent
set productkey=XQQYW-NFFMW-XJPBH-K8732-CKFFD
set editionid=IoTEnterprise
set productname=Windows 10 IoT Enterprise
set compositioneditionid=Enterprise
goto mainmenu

Rem Windows ¼ÒÍ¥µ¥ÓïÑÔ°æ
:setvarcoresl
set productkey=BT79Q-G7N6G-PGBYW-4YWX6-6F4BT
set editionid=CoreSingleLanguage
set productname=Windows 10 Home Single Language
set compositioneditionid=Core
goto mainmenu

Rem Windows SE ÔÆ°æ±¾
:setvarcloud
set productkey=KY7PN-VR6RX-83W6Y-6DDYQ-T6R4W
set editionid=CloudEdition
set productname=Windows 10 SE
set compositioneditionid=Enterprise
goto mainmenu

Rem Windows ¼ÒÍ¥°æ N
:setvarcoren
set productkey=4CPRK-NM3K3-X6XXQ-RXX86-WXCHW
set editionid=CoreN
set productname=Windows 10 Home N
set compositioneditionid=CoreN
goto mainmenu

Rem Windows ×¨Òµ°æ N
:setvarpron
set productkey=2B87N-8KFHP-DKV6R-Y2C8J-PKCKT
set editionid=ProfessionalN
set productname=Windows 10 Pro N
set compositioneditionid=EnterpriseN
goto mainmenu

Rem Windows ×¨Òµ¹¤×÷Õ¾°æ N
:setvarpfwn
set productkey=WYPNQ-8C467-V2W6J-TX4WX-WT2RQ
set editionid=ProfessionalWorkstationN
set productname=Windows 10 Pro N for Workstations
set compositioneditionid=EnterpriseN
goto mainmenu

Rem Windows ×¨Òµ½ÌÓý°æ N
:setvarproedn
set productkey=GJTYN-HDMQY-FRR76-HVGC7-QPF8P
set editionid=ProfessionalEducationN
set productname=Windows 10 Pro Education N
set compositioneditionid=EnterpriseN
goto mainmenu

Rem Windows ½ÌÓý°æ N
:setvaredn
set productkey=84NGF-MHBT6-FXBX8-QWJK7-DRR8H
set editionid=EducationN
set productname=Windows 10 Education N
set compositioneditionid=EnterpriseN
goto mainmenu

Rem Windows ÆóÒµ°æ N
:setvarentn
set productkey=3V6Q6-NQXCX-V8YXR-9QCYV-QPFCT
set editionid=EnterpriseN
set productname=Windows 10 Enterprise N
set compositioneditionid=EnterpriseN
goto mainmenu

Rem Windows SE ÔÆ°æ±¾ N
:setvarcloudn
set productkey=K9VKN-3BGWV-Y624W-MCRMQ-BHDCD
set editionid=CloudEditionN
set productname=Windows 10 SE N
set compositioneditionid=EnterpriseN
goto mainmenu

Rem Windows 10 ÆóÒµ°æ LTSC 2021
:setvarltsc2021
set productkey=M7XTQ-FN8P6-TTKYV-9D4CC-J462D
set editionid=EnterpriseS
set productname=Windows 10 Enterprise LTSC 2021
set compositioneditionid=EnterpriseS
goto mainmenu

Rem Windows 10 IoT ÆóÒµ°æ LTSC 2021
:setvariotltsc2021
set productkey=QPM6N-7J2WJ-P88HH-P3YRH-YY74H
set editionid=IoTEnterpriseS
set productname=Windows 10 IoT Enterprise LTSC 2021
set compositioneditionid=EnterpriseS
goto mainmenu

Rem Windows 10 ÆóÒµ°æ N LTSC 2021
:setvarltscn2021
set productkey=2D7NQ-3MDXF-9WTDT-X9CCP-CKD8V
set editionid=EnterpriseSN
set productname=Windows 10 Enterprise N LTSC 2021
set compositioneditionid=EnterpriseSN
goto mainmenu

Rem Windows 11 ÆóÒµ°æ LTSC 2024
:setvarltsc2024
set productkey=M7XTQ-FN8P6-TTKYV-9D4CC-J462D
set editionid=EnterpriseS
set productname=Windows 10 Enterprise LTSC 2024
set compositioneditionid=EnterpriseS
goto mainmenu

Rem Windows 11 IoT ÆóÒµ°æ LTSC 2024
:setvariotltsc2024
set productkey=KBN8V-HFGQ4-MGXVD-347P6-PDQGT
set editionid=IoTEnterpriseS
set productname=Windows 10 IoT Enterprise LTSC 2024
set compositioneditionid=EnterpriseS
goto mainmenu

Rem Windows 11 ÆóÒµ°æ N LTSC 2024
:setvarltscn2024
set productkey=92NFX-8DJQP-P6BBQ-THF9C-7CG2H
set editionid=EnterpriseSN
set productname=Windows 10 Enterprise N LTSC 2024
set compositioneditionid=EnterpriseSN
goto mainmenu

Rem Windows 11 IoT ÆóÒµ°æ LTSC ¶©ÔÄ°æ 2024
:setvariotltscsub2024
set productkey=N979K-XWD77-YW3GB-HBGH6-D32MH
set editionid=IoTEnterpriseSK
set productname=Windows 10 IoT Enterprise Subscription LTSC 2024
set compositioneditionid=EnterpriseS
goto mainmenu

Rem Windows Server 2022 ±ê×¼°æ/´ø×ÀÃæÌåÑéµÄ±ê×¼°æ
:setvarserv22std
set productkey=VDYBN-27WPP-V4HQT-9VMD4-VMK7H
set editionid=ServerStandard
set productname=Windows Server 2022 Standard
set compositioneditionid=ServerStandard
goto mainmenu

Rem Windows Server 2022 Êý¾ÝÖÐÐÄ°æ/´ø×ÀÃæÌåÑéµÄÊý¾ÝÖÐÐÄ°æ
:setvarserv22data
set productkey=WX4NM-KYWYW-QJJR4-XV3QB-6VM33
set editionid=ServerDatacenter
set productname=Windows Server 2022 Datacenter
set compositioneditionid=ServerDatacenter
goto mainmenu

Rem Windows Server 2025 ±ê×¼°æ/´ø×ÀÃæÌåÑéµÄ±ê×¼°æ
:setvarserv25std
set productkey=DPNXD-67YY9-WWFJJ-RYH99-RM832
set editionid=ServerStandard
set productname=Windows Server 2025 Standard
set compositioneditionid=ServerStandard
goto mainmenu

Rem Windows Server 2025 Êý¾ÝÖÐÐÄ°æ/´ø×ÀÃæÌåÑéµÄÊý¾ÝÖÐÐÄ°æ
:setvarserv25data
set productkey=CNFDQ-2BW8H-9V4WM-TKCPD-MD2QF
set editionid=ServerDatacenter
set productname=Windows Server 2025 Datacenter
set compositioneditionid=ServerDatacenter
goto mainmenu

:endofbatch
exit