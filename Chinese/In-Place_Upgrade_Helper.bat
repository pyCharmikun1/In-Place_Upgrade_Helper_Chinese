@echo off

Rem ��ȡ����ԱȨ��
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
echo ����˴���δ��󻯣����ֶ�������С��
echo ���� Windows �ն˵�һ����֪���⡣
echo.
SETLOCAL
Rem �Զ�����ϵͳ����
for /f "tokens=2*" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName') do set productname=%%j
for /f "tokens=2*" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v EditionID') do set editionid=%%j
for /f "tokens=2*" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CompositionEditionID') do set compositioneditionid=%%j
Rem �������Ƿ����ã���δ������ʹ��Ĭ��ֵ
if "%productname%"=="" set productname=Windows 10 Pro
if "%editionid%"=="" set editionid=Professional
if "%compositioneditionid%"=="" set compositioneditionid=Enterprise

set "choice="
set sourcespath=.

:premainmenu
if not exist "%sourcespath%"\setup.exe goto nosetupfound
if not exist "%sourcespath%"\sources\ goto nosetupfound
echo �ҵ���װ�ļ�
echo.
echo �����ѡ�汾�ڰ�װ�����ϲ����ã�Windows ��װ���������������ĳЩ�汾��
echo ����ͼ��
echo.
echo �ɰ�װ�汾                     ��װ��������Ҫ�İ汾
echo.
echo Windows Pro                                   Windows Pro
echo Windows Pro for Workstations                  Windows Pro
echo Windows Education                             Windows Pro
echo Windows Pro Education                         Windows Pro
echo Windows Enterprise                            Windows Pro
echo Windows Enterprise multi-session              Windows Pro
echo Windows IoT Enterprise                        Windows Pro
echo Windows SE [Cloud] (��Win11)                  Windows Pro
echo Windows Home                                  Windows Home
echo Windows Home Single Language                  Windows Home
echo Windows Pro N                                 Windows Pro N
echo Windows Pro N for Workstations                Windows Pro N
echo Windows Education N                           Windows Pro N
echo Windows Pro Education N                       Windows Pro N
echo Windows Enterprise N                          Windows Pro N
echo Windows SE [Cloud] N (��Win11)                Windows Pro N
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
echo ��������г���װ�����ϵĿ��ð汾��
pause>nul|set/p=&echo(
echo ���ڶ�ȡ��װ���ʣ����Ժ�...
if exist "%sourcespath%\sources\install.wim" powershell -ExecutionPolicy Bypass -Command "Get-WindowsImage -ImagePath '%sourcespath%\sources\install.wim' | Select-Object -Property ImageName, ImageIndex"
if exist "%sourcespath%\sources\install.esd" powershell -ExecutionPolicy Bypass -Command "Get-WindowsImage -ImagePath '%sourcespath%\sources\install.esd' | Select-Object -Property ImageName, ImageIndex"
if exist "%sourcespath%\sources\install.swm" powershell -ExecutionPolicy Bypass -Command "Get-WindowsImage -ImagePath '%sourcespath%\sources\install.swm' | Select-Object -Property ImageName, ImageIndex"
echo ������������͵��������֡�
pause>nul|set/p=&echo(


:mainmenu
cls
ECHO M-M-C ���پ͵��������� for Win10/11
echo V0.93
echo.
echo ��������汾�ı�ţ����س���ѡ������������Ȼ���ٴΰ��س���
echo.
if "%productkey%"=="" echo ��Ʒ����: [92m%productname%[0m [93m(��ע����ȡ)[0m
if not "%productkey%"=="" echo ��Ʒ����: [92m%productname%[0m
echo (ע����ֵ������ʾ"Windows 10"����ʹ��װ�� Windows 11)
echo �汾ID: [92m%editionid%[0m
if "%productkey%"=="" echo OEM��Ʒ��Կ: [93mδѡ��汾[0m
if not "%productkey%"=="" echo OEM��Ʒ��Կ: [92m%productkey%[0m
echo (΢��ٷ�Ԥ��װ��Կ�������ڼ���)
echo ��ϰ汾ID: [92m%compositioneditionid%[0m
echo (�����汾��ʵ�ʰ汾�ڼ����ϻ��ڴ˰汾����)
echo.
echo ��׼�汾��
echo 1) Windows ��ͥ��                       10) Windows 11 SE �ư汾
echo 2) Windows רҵ��                       11) Windows ��ͥ�� N
echo 3) Windows רҵ����վ��                 12) Windows רҵ�� N
echo 4) Windows ��ҵ��                       13) Windows רҵ����վ�� N
echo 5) Windows רҵ������                   14) Windows רҵ������ N
echo 6) Windows ������                       15) Windows ������ N
echo 7) Windows ��ҵ���Ự                 16) Windows ��ҵ�� N
echo 8) Windows IoT ��ҵ��                   17) Windows 11 SE �ư汾 N
echo 9) Windows ��ͥ�����԰�
echo LTSC���ڷ���棺
echo 18) Windows 10 ��ҵ�� LTSC 2021         22) Windows 11 IoT ��ҵ�� LTSC 2024
echo 19) Windows 10 IoT ��ҵ�� LTSC 2021     23) Windows 11 ��ҵ�� N LTSC 2024
echo 20) Windows 10 ��ҵ�� N LTSC 2021       24) Windows 11 IoT ��ҵ�� LTSC ���İ� 2024
echo 21) Windows 11 ��ҵ�� LTSC 2024
echo �������汾��
echo 25) Windows Server 2022 ��׼��          27) Windows Server 2025 ��׼��
echo 26) Windows Server 2022 �������İ�      28) Windows Server 2025 �������İ�
echo.
echo k) ���� 1 - ����ʹ�� slmgr ��װ��ѡ��Կ���򵥰汾���ģ�����͵�������
echo s) ���� 2 - ��ʼ��������ѡ��汾���ɰ�װ�������о�������ͬ�������ľ͵�����
echo u) ���� 3 - ��ʼ��������ѡ�汾��ʹ����Ӧ��Ԥ��װ��Կ���а�װ
echo f) ���� 4 - ��ʼǿ����������ѡ�汾��ʹ����Ӧ��Ԥ��װ��Կ���а�װ
echo.
echo 0) �˳�

set "choice="
set /p choice=��ѡ�� 
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
ECHO δ�ҵ�"%choice%"������������ԡ�&ECHO. &pause>nul|set/p=&echo(
ECHO.
goto mainmenu

:keychange
if "%productkey%"=="" goto nokeyselected
echo ����ͨ���򵥸�����Կ�����İ汾...
slmgr /ipk %productkey%
goto mainmenu

:runboringupgrade
echo.
echo ��װ����ͺ�̨�����������У����Ժ򡣴˴��ڽ��Զ��رա�
%sourcespath%\setup.exe /eula accept /telemetry disable /priority normal /resizerecoverypartition enable
goto endofbatch

:runupgrade
if "%productkey%"=="" goto nokeyselected
echo.
echo ��װ����ͺ�̨�����������У����Ժ򡣴˴��ڽ��Զ��رա�
%sourcespath%\setup.exe /eula accept /telemetry disable /priority normal /resizerecoverypartition enable /pkey %productkey%
goto endofbatch

:runforcedupgrade
if "%productkey%"=="" goto nokeyselected
echo.
echo ͨ��"α��"ע����еĲ�ͬ�汾��ǿ�ƽ��о͵�����������Ӧ�ú����ã�����ѡ�汾��
echo ���磬���Ҫ��װרҵ�棬��ע����е�"ProductName"��"EditionID"����רҵ���ֵ���ǡ�
echo ��װ�������Ϊרҵ���Ѱ�װ��������ִ�о͵�������
echo �����Ϳ���ִ�в��ڹٷ�����·���еľ͵������������רҵ�潵������ͥ�档
echo �������Խ��������ԭ�����ֹ������·��������Ӽ�ͥ��ֱ����������ҵ�档
echo ���߸����µĲ������� Win10 ������������ Win10 IoT ��ҵ�� LTSC Ҳ�ǿ��ܵġ�
echo.
echo �⵱Ȼ��ȫ����΢��֧�֣������ге�ʹ�÷��ա�
echo ���ǣ���ĿǰΪֹ��δ�������⣬������Ϊ���������ľ͵�����һ����
echo �����С�Ľ�����İ汾д��ע���ֻ��ʹ����ȷ�İ汾��������ǿ�ƾ͵��������ɡ�
echo.
echo ȷ��Ҫ�����𣿷����������رմ˴��ڣ�
echo.
pause>nul|set/p=�������������&echo(
echo.
echo ��������ע�����...
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "EditionID" /t REG_SZ /d "%editionid%" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "ProductName" /t REG_SZ /d "%productname%" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "CompositionEditionID" /t REG_SZ /d "%compositioneditionid%" /f
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion" /v "EditionID" /t REG_SZ /d "%editionid%" /f /reg:32
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion" /v "ProductName" /t REG_SZ /d "%productname%" /f /reg:32
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion" /v "CompositionEditionID" /t REG_SZ /d "%compositioneditionid%" /f /reg:32
echo.
echo ��װ����ͺ�̨�����������У����Ժ򡣴˴��ڽ��Զ��رա�
%sourcespath%\setup.exe /eula accept /telemetry disable /priority normal /resizerecoverypartition enable /pkey %productkey%
goto endofbatch

:nosetupfound
echo δ�ҵ� Setup.exe ��/�� Sources �ļ��У�δ�����߸��Ƶ���װ�ļ���
echo ����ʹ���ⲿ��װ����...
set /p sourcespath=�����밲װ���ʵ�·�������� F:\ �� D:\unpackedISO\���� 
goto premainmenu

:nokeyselected
echo ����ѡ�� Windows �汾��
echo.
pause>nul|set/p=�������������&echo(
goto mainmenu

Rem �˴����岻ͬ�� Windows �汾

Rem Windows ��ͥ��
:setvarcore
set productkey=YTMG3-N6DKC-DKB77-7M9GH-8HVX7
set editionid=Core
set productname=Windows 10 Home
set compositioneditionid=Core
goto mainmenu

Rem Windows רҵ��
:setvarpro
set productkey=VK7JG-NPHTM-C97JM-9MPGT-3V66T
set editionid=Professional
set productname=Windows 10 Pro
set compositioneditionid=Enterprise
goto mainmenu

Rem Windows רҵ����վ��
:setvarpfw
set productkey=DXG7C-N36C4-C4HTG-X4T3X-2YV77
set editionid=ProfessionalWorkstation
set productname=Windows 10 Pro for Workstations
set compositioneditionid=Enterprise
goto mainmenu

Rem Windows ��ҵ��
:setvarent
set productkey=XGVPP-NMH47-7TTHJ-W3FW7-8HV2C
set editionid=Enterprise
set productname=Windows 10 Enterprise
set compositioneditionid=Enterprise
goto mainmenu

Rem Windows רҵ������
:setvarproed
set productkey=8PTT6-RNW4C-6V7J2-C2D3X-MHBPB
set editionid=ProfessionalEducation
set productname=Windows 10 Pro Education
set compositioneditionid=Enterprise
goto mainmenu

Rem Windows ������
:setvared
set productkey=YNMGQ-8RYV3-4PGQ3-C8XTP-7CFBY
set editionid=Education
set productname=Windows 10 Education
set compositioneditionid=Enterprise
goto mainmenu

Rem Windows ��ҵ���Ự/��������
:setvarentmulti
set productkey=CPWHC-NT2C7-VYW78-DHDB2-PG3GK
set editionid=ServerRdsh
set productname=Windows 10 Enterprise multi-session
set compositioneditionid=Enterprise
goto mainmenu

Rem Windows IoT ��ҵ��
:setvariotent
set productkey=XQQYW-NFFMW-XJPBH-K8732-CKFFD
set editionid=IoTEnterprise
set productname=Windows 10 IoT Enterprise
set compositioneditionid=Enterprise
goto mainmenu

Rem Windows ��ͥ�����԰�
:setvarcoresl
set productkey=BT79Q-G7N6G-PGBYW-4YWX6-6F4BT
set editionid=CoreSingleLanguage
set productname=Windows 10 Home Single Language
set compositioneditionid=Core
goto mainmenu

Rem Windows SE �ư汾
:setvarcloud
set productkey=KY7PN-VR6RX-83W6Y-6DDYQ-T6R4W
set editionid=CloudEdition
set productname=Windows 10 SE
set compositioneditionid=Enterprise
goto mainmenu

Rem Windows ��ͥ�� N
:setvarcoren
set productkey=4CPRK-NM3K3-X6XXQ-RXX86-WXCHW
set editionid=CoreN
set productname=Windows 10 Home N
set compositioneditionid=CoreN
goto mainmenu

Rem Windows רҵ�� N
:setvarpron
set productkey=2B87N-8KFHP-DKV6R-Y2C8J-PKCKT
set editionid=ProfessionalN
set productname=Windows 10 Pro N
set compositioneditionid=EnterpriseN
goto mainmenu

Rem Windows רҵ����վ�� N
:setvarpfwn
set productkey=WYPNQ-8C467-V2W6J-TX4WX-WT2RQ
set editionid=ProfessionalWorkstationN
set productname=Windows 10 Pro N for Workstations
set compositioneditionid=EnterpriseN
goto mainmenu

Rem Windows רҵ������ N
:setvarproedn
set productkey=GJTYN-HDMQY-FRR76-HVGC7-QPF8P
set editionid=ProfessionalEducationN
set productname=Windows 10 Pro Education N
set compositioneditionid=EnterpriseN
goto mainmenu

Rem Windows ������ N
:setvaredn
set productkey=84NGF-MHBT6-FXBX8-QWJK7-DRR8H
set editionid=EducationN
set productname=Windows 10 Education N
set compositioneditionid=EnterpriseN
goto mainmenu

Rem Windows ��ҵ�� N
:setvarentn
set productkey=3V6Q6-NQXCX-V8YXR-9QCYV-QPFCT
set editionid=EnterpriseN
set productname=Windows 10 Enterprise N
set compositioneditionid=EnterpriseN
goto mainmenu

Rem Windows SE �ư汾 N
:setvarcloudn
set productkey=K9VKN-3BGWV-Y624W-MCRMQ-BHDCD
set editionid=CloudEditionN
set productname=Windows 10 SE N
set compositioneditionid=EnterpriseN
goto mainmenu

Rem Windows 10 ��ҵ�� LTSC 2021
:setvarltsc2021
set productkey=M7XTQ-FN8P6-TTKYV-9D4CC-J462D
set editionid=EnterpriseS
set productname=Windows 10 Enterprise LTSC 2021
set compositioneditionid=EnterpriseS
goto mainmenu

Rem Windows 10 IoT ��ҵ�� LTSC 2021
:setvariotltsc2021
set productkey=QPM6N-7J2WJ-P88HH-P3YRH-YY74H
set editionid=IoTEnterpriseS
set productname=Windows 10 IoT Enterprise LTSC 2021
set compositioneditionid=EnterpriseS
goto mainmenu

Rem Windows 10 ��ҵ�� N LTSC 2021
:setvarltscn2021
set productkey=2D7NQ-3MDXF-9WTDT-X9CCP-CKD8V
set editionid=EnterpriseSN
set productname=Windows 10 Enterprise N LTSC 2021
set compositioneditionid=EnterpriseSN
goto mainmenu

Rem Windows 11 ��ҵ�� LTSC 2024
:setvarltsc2024
set productkey=M7XTQ-FN8P6-TTKYV-9D4CC-J462D
set editionid=EnterpriseS
set productname=Windows 10 Enterprise LTSC 2024
set compositioneditionid=EnterpriseS
goto mainmenu

Rem Windows 11 IoT ��ҵ�� LTSC 2024
:setvariotltsc2024
set productkey=KBN8V-HFGQ4-MGXVD-347P6-PDQGT
set editionid=IoTEnterpriseS
set productname=Windows 10 IoT Enterprise LTSC 2024
set compositioneditionid=EnterpriseS
goto mainmenu

Rem Windows 11 ��ҵ�� N LTSC 2024
:setvarltscn2024
set productkey=92NFX-8DJQP-P6BBQ-THF9C-7CG2H
set editionid=EnterpriseSN
set productname=Windows 10 Enterprise N LTSC 2024
set compositioneditionid=EnterpriseSN
goto mainmenu

Rem Windows 11 IoT ��ҵ�� LTSC ���İ� 2024
:setvariotltscsub2024
set productkey=N979K-XWD77-YW3GB-HBGH6-D32MH
set editionid=IoTEnterpriseSK
set productname=Windows 10 IoT Enterprise Subscription LTSC 2024
set compositioneditionid=EnterpriseS
goto mainmenu

Rem Windows Server 2022 ��׼��/����������ı�׼��
:setvarserv22std
set productkey=VDYBN-27WPP-V4HQT-9VMD4-VMK7H
set editionid=ServerStandard
set productname=Windows Server 2022 Standard
set compositioneditionid=ServerStandard
goto mainmenu

Rem Windows Server 2022 �������İ�/������������������İ�
:setvarserv22data
set productkey=WX4NM-KYWYW-QJJR4-XV3QB-6VM33
set editionid=ServerDatacenter
set productname=Windows Server 2022 Datacenter
set compositioneditionid=ServerDatacenter
goto mainmenu

Rem Windows Server 2025 ��׼��/����������ı�׼��
:setvarserv25std
set productkey=DPNXD-67YY9-WWFJJ-RYH99-RM832
set editionid=ServerStandard
set productname=Windows Server 2025 Standard
set compositioneditionid=ServerStandard
goto mainmenu

Rem Windows Server 2025 �������İ�/������������������İ�
:setvarserv25data
set productkey=CNFDQ-2BW8H-9V4WM-TKCPD-MD2QF
set editionid=ServerDatacenter
set productname=Windows Server 2025 Datacenter
set compositioneditionid=ServerDatacenter
goto mainmenu

:endofbatch
exit