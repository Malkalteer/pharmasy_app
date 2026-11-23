; ملف تنصيب برنامج إدارة الصيدلية (NSIS 3 - مجاني حتى للاستخدام التجاري)
; يحتوي كل ما يحتاجه البرنامج: ملفات Flutter، مكتبة SQLite المشفرة، الخطوط،
; ومكتبات Visual C++ Runtime — لا يحتاج أي اتصال بالإنترنت أو تثبيت إضافي.
;
; البناء (بعد flutter build windows --release):
;   makensis /DAPP_VERSION=1.0.0 installer\pharmacy_setup.nsi
; الناتج: build\installer\PharmacyManager-Setup-<الإصدار>.exe

Unicode true
ManifestDPIAware true
SetCompressor /SOLID lzma

!ifndef APP_VERSION
  !define APP_VERSION "1.0.0"
!endif
!define APP_NAME "نظام إدارة الصيدلية"
!define APP_EXE "PharmacyManager.exe"
!define APP_DIR_NAME "PharmacyManager"
!define BUILD_DIR "..\build\windows\x64\runner\Release"
!define UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\PharmacyManager"

Name "${APP_NAME}"
OutFile "..\build\installer\PharmacyManager-Setup-${APP_VERSION}.exe"
InstallDir "$PROGRAMFILES64\${APP_DIR_NAME}"
InstallDirRegKey HKLM "${UNINST_KEY}" "InstallLocation"
RequestExecutionLevel admin
BrandingText "${APP_NAME} ${APP_VERSION}"

VIProductVersion "${APP_VERSION}.0"
VIAddVersionKey /LANG=0 "ProductName" "Pharmacy Manager"
VIAddVersionKey /LANG=0 "FileDescription" "Pharmacy Manager Setup"
VIAddVersionKey /LANG=0 "FileVersion" "${APP_VERSION}"
VIAddVersionKey /LANG=0 "ProductVersion" "${APP_VERSION}"
VIAddVersionKey /LANG=0 "LegalCopyright" "Pharmacy Manager"

!include "MUI2.nsh"
!include "x64.nsh"
!include "WinVer.nsh"
!include "LogicLib.nsh"

!define MUI_ICON "..\windows\runner\resources\app_icon.ico"
!define MUI_UNICON "..\windows\runner\resources\app_icon.ico"
!define MUI_ABORTWARNING
!define MUI_FINISHPAGE_RUN "$INSTDIR\${APP_EXE}"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "Arabic"
!insertmacro MUI_LANGUAGE "English"

Function .onInit
  StrCpy $LANGUAGE ${LANG_ARABIC}
  ${IfNot} ${RunningX64}
    MessageBox MB_ICONSTOP "هذا البرنامج يحتاج Windows بنظام 64 بت."
    Abort
  ${EndIf}
  ${IfNot} ${AtLeastWin10}
    MessageBox MB_ICONSTOP "هذا البرنامج يحتاج Windows 10 أو أحدث."
    Abort
  ${EndIf}
  SetRegView 64
FunctionEnd

Function un.onInit
  StrCpy $LANGUAGE ${LANG_ARABIC}
  SetRegView 64
FunctionEnd

; التأكد من أن البرنامج مغلق قبل التثبيت أو التحديث
!macro CheckAppClosed
  check:
  nsExec::ExecToStack 'cmd /c tasklist /FI "IMAGENAME eq ${APP_EXE}" | find /I "${APP_EXE}"'
  Pop $0
  Pop $1
  ${If} $0 == 0
    MessageBox MB_RETRYCANCEL|MB_ICONEXCLAMATION "البرنامج مفتوح حالياً. أغلقه ثم اضغط إعادة المحاولة." IDRETRY check
    Abort
  ${EndIf}
!macroend

Section "البرنامج (مطلوب)" SecMain
  SectionIn RO
  !insertmacro CheckAppClosed
  SetShellVarContext all
  SetOutPath "$INSTDIR"
  ; كل ملفات البرنامج المبنية (exe + dll + data + المكتبات الأصلية)
  File /r "${BUILD_DIR}\*.*"
  ; مكتبات Visual C++ بجانب البرنامج (لا حاجة لتثبيت VC++ Redistributable)
  File /nonfatal "vcruntime\msvcp140.dll"
  File /nonfatal "vcruntime\vcruntime140.dll"
  File /nonfatal "vcruntime\vcruntime140_1.dll"

  CreateDirectory "$SMPROGRAMS\${APP_NAME}"
  CreateShortcut "$SMPROGRAMS\${APP_NAME}\${APP_NAME}.lnk" "$INSTDIR\${APP_EXE}"
  CreateShortcut "$SMPROGRAMS\${APP_NAME}\إلغاء التثبيت.lnk" "$INSTDIR\Uninstall.exe"

  WriteUninstaller "$INSTDIR\Uninstall.exe"
  WriteRegStr HKLM "${UNINST_KEY}" "DisplayName" "${APP_NAME}"
  WriteRegStr HKLM "${UNINST_KEY}" "DisplayVersion" "${APP_VERSION}"
  WriteRegStr HKLM "${UNINST_KEY}" "Publisher" "Pharmacy Manager"
  WriteRegStr HKLM "${UNINST_KEY}" "DisplayIcon" "$INSTDIR\${APP_EXE}"
  WriteRegStr HKLM "${UNINST_KEY}" "InstallLocation" "$INSTDIR"
  WriteRegStr HKLM "${UNINST_KEY}" "UninstallString" '"$INSTDIR\Uninstall.exe"'
  WriteRegDWORD HKLM "${UNINST_KEY}" "NoModify" 1
  WriteRegDWORD HKLM "${UNINST_KEY}" "NoRepair" 1
SectionEnd

Section "اختصار على سطح المكتب" SecDesktop
  SetShellVarContext all
  CreateShortcut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\${APP_EXE}"
SectionEnd

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SecMain} "ملفات البرنامج الأساسية."
  !insertmacro MUI_DESCRIPTION_TEXT ${SecDesktop} "إنشاء أيقونة للبرنامج على سطح المكتب."
!insertmacro MUI_FUNCTION_DESCRIPTION_END

; ملاحظة: بيانات الصيدلية (قاعدة البيانات والنسخ الاحتياطية والتفعيل) محفوظة في
; %APPDATA%\com.pharmasy\Pharmacy Manager ولا تُحذف عند إلغاء التثبيت.
Section "Uninstall"
  !insertmacro CheckAppClosed
  SetShellVarContext all
  Delete "$DESKTOP\${APP_NAME}.lnk"
  RMDir /r "$SMPROGRAMS\${APP_NAME}"
  ; حذف ملفات البرنامج فقط (وليس المجلد كاملاً، تحسباً لاختيار مجلد مشترك بالخطأ)
  RMDir /r "$INSTDIR\data"
  Delete "$INSTDIR\${APP_EXE}"
  Delete "$INSTDIR\*.dll"
  Delete "$INSTDIR\native_assets.json"
  Delete "$INSTDIR\Uninstall.exe"
  RMDir "$INSTDIR"
  DeleteRegKey HKLM "${UNINST_KEY}"
SectionEnd
