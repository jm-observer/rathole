@echo off
SETLOCAL EnableDelayedExpansion
set "line="
set "tok= && "
for %%a in (
"cargo build --package %P_APP% --bin %C_APP% --release"
"rm -rf target/%C_APP%-aarch64 "
"upx --best --lzma -o ./target/%C_APP%-aarch64 ./target/aarch64-unknown-linux-gnu/release/%C_APP%"
"scp -o 'StrictHostKeyChecking=no' ./target/%C_APP%-aarch64 pi@%PiIp%:/tmp/%C_APP%"
) do  (
set line=!line!%%~a!tok!
)
rem set line="%line:~0,-4%"
@echo on
docker run --rm -it -v %userprofile%\.git-credentials:/root/.git-credentials -v %cd%:/root/src ^
    -e DATABASE_URL=mysql://listening:listening@%PiIp%:13306/listening ^
    -v %userprofile%\aarch64\registry:/root/.cargo/registry -v %userprofile%\aarch64\/git:/root/.cargo/git ^
    %AARCH64_IMAGE% ^
    sh -c "%line:~0,-4%" 