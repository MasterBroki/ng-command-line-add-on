echo off
SET nomComponent=%1
if exist "%nomComponent%\NUL" goto end
call ng generate component %nomComponent%
cd "%nomComponent%"

ren "%nomComponent%.component.html" "%nomComponent%.template.html"
ren "%nomComponent%.component.css" "%nomComponent%.stylesheet.css"
powershell -Command "(gc %nomComponent%.component.ts) -replace '%nomComponent%.component.html', '%nomComponent%.template.html' | Out-File %nomComponent%.component.ts"
powershell -Command "(gc %nomComponent%.component.ts) -replace '%nomComponent%.component.css', '%nomComponent%.stylesheet.css' | Out-File %nomComponent%.component.ts"
powershell -Command "(gc %nomComponent%.component.ts) -replace 'app-%nomComponent%', '%nomComponent%' | Out-File %nomComponent%.component.ts"
git add "%nomComponent%.component.ts"
git add "%nomComponent%.template.html"
git add "%nomComponent%.stylesheet.css"
cd ../
:end