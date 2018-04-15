@echo off
if /I "%1" == "" (
echo "Component name not defined"
goto end
)
SET nomComponent=%1
if exist "%nomComponent%\NUL" goto end
@echo on
call ng generate component %nomComponent%
@echo off
ren "%nomComponent%\%nomComponent%.component.html" "%nomComponent%\%nomComponent%.template.html"
ren "%nomComponent%\%nomComponent%.component.css" "%nomComponent%\%nomComponent%.stylesheet.css"
powershell -Command "(gc %nomComponent%\%nomComponent%.component.ts) -replace '%nomComponent%.component.html', '%nomComponent%.template.html' | Out-File %nomComponent%\%nomComponent%.component.ts"
powershell -Command "(gc %nomComponent%\%nomComponent%.component.ts) -replace '%nomComponent%.component.css', '%nomComponent%.stylesheet.css' | Out-File %nomComponent%\%nomComponent%.component.ts"
powershell -Command "(gc %nomComponent%\%nomComponent%.component.ts) -replace 'app-%nomComponent%', '%nomComponent%' | Out-File %nomComponent%\%nomComponent%.component.ts"
git add "%nomComponent%\%nomComponent%.component.ts"
git add "%nomComponent%\%nomComponent%.template.html"
git add "%nomComponent%\%nomComponent%.stylesheet.css"
:end