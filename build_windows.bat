@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo === Сборка «Читалки» для Windows 7 ===
where node >nul 2>nul
if errorlevel 1 (
  echo Не найден Node.js 12.22.12. Установите его и перезапустите файл.
  pause
  exit /b 1
)
echo Версия Node.js:
node --version
echo.
if not exist node_modules (
  echo Устанавливаем зависимости. Нужен интернет...
  call npm install
  if errorlevel 1 (echo Ошибка установки зависимостей.& pause & exit /b 1)
)
echo Собираем 32-битную portable-версию, совместимую с Windows 7...
call npm run build:win
if errorlevel 1 (echo Сборка завершилась с ошибкой.& pause & exit /b 1)
echo.
echo Готовый EXE находится в папке dist.
pause
