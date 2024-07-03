@echo off
setlocal

:: Set environment for Windows build
set GOOS=windows

:: Build for Windows
go build -trimpath -ldflags "-s -w" -buildvcs=false -o bin\frps.exe .\cmd\frps
go build -trimpath -ldflags "-s -w" -buildvcs=false -o bin\frpc.exe .\cmd\frpc

:: Set environment for Linux build
set GOOS=linux

:: Build for Linux
go build -trimpath -ldflags "-s -w" -buildvcs=false -o bin/frps .\cmd\frps
go build -trimpath -ldflags "-s -w" -buildvcs=false -o bin/frpc .\cmd\frpc

endlocal
pause
