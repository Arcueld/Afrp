@echo off
setlocal

set CGO_ENABLED=0
set GOARCH=amd64

:: Set environment for Windows build
set GOOS=windows

:: Build for Windows
garble build -trimpath -ldflags "-s -w" -buildvcs=false -o bin\frps.exe .\cmd\frps
garble build -trimpath -ldflags "-s -w" -buildvcs=false -o bin\frpc.exe .\cmd\frpc

:: Set environment for Linux build
set GOOS=linux

:: Build for Linux
garble build -trimpath -ldflags "-s -w" -buildvcs=false -o bin/frps .\cmd\frps
garble build -trimpath -ldflags "-s -w" -buildvcs=false -o bin/frpc .\cmd\frpc

endlocal
pause
