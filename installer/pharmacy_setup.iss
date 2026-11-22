; ملف تنصيب برنامج إدارة الصيدلية (Inno Setup 6)
; يحتوي كل ما يحتاجه البرنامج: ملفات Flutter، مكتبة SQLite المشفرة، الخطوط،
; ومكتبات Visual C++ Runtime — لا يحتاج أي اتصال بالإنترنت أو تثبيت إضافي.
;
; البناء:  iscc /DAppVersion=1.0.0 installer\pharmacy_setup.iss
; (يُشغَّل بعد: flutter build windows --release)

#ifndef AppVersion
  #define AppVersion "1.0.0"
#endif
#define AppName "Pharmacy Manager"
#define AppNameAr "نظام إدارة الصيدلية"
#define AppExe "PharmacyManager.exe"
#define BuildDir "..\build\windows\x64\runner\Release"

[Setup]
AppId={{8F3B6C2A-4E1D-4B7A-9C55-3D2F7A1E9B10}
AppName={#AppNameAr}
AppVersion={#AppVersion}
AppVerName={#AppNameAr} {#AppVersion}
AppPublisher=Pharmacy Manager
DefaultDirName={autopf}\PharmacyManager
DefaultGroupName={#AppNameAr}
DisableProgramGroupPage=yes
OutputDir=..\build\installer
OutputBaseFilename=PharmacyManager-Setup-{#AppVersion}
SetupIconFile=..\windows\runner\resources\app_icon.ico
UninstallDisplayIcon={app}\{#AppExe}
Compression=lzma2/max
SolidCompression=yes
WizardStyle=modern
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
PrivilegesRequired=admin
MinVersion=10.0

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

[Files]
; كل ملفات البرنامج المبنية (exe + dll + data + المكتبات الأصلية)
Source: "{#BuildDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; مكتبات Visual C++ (تُنسخ بجانب البرنامج حتى لا يحتاج الجهاز لتثبيت VC++ Redistributable)
Source: "vcruntime\*.dll"; DestDir: "{app}"; Flags: ignoreversion skipifsourcedoesntexist

[Icons]
Name: "{group}\{#AppNameAr}"; Filename: "{app}\{#AppExe}"
Name: "{group}\{cm:UninstallProgram,{#AppNameAr}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#AppNameAr}"; Filename: "{app}\{#AppExe}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#AppExe}"; Description: "{cm:LaunchProgram,{#AppNameAr}}"; Flags: nowait postinstall skipifsilent

; ملاحظة: بيانات الصيدلية (قاعدة البيانات والنسخ الاحتياطية) محفوظة في
; %APPDATA%\com.pharmasy\Pharmacy Manager ولا تُحذف عند إلغاء التثبيت.
