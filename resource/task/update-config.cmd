@echo off
echo Updating config to %PiIp%...

echo Creating rathole directory if not exists...
ssh pi@%PiIp% "mkdir -p ~/rathole"

echo Uploading config...
scp -o "StrictHostKeyChecking=no" ./resource/client.toml pi@%PiIp%:~/rathole/
scp -o "StrictHostKeyChecking=no" ./resource/server.toml pi@%PiIp%:~/rathole/

echo Restart rathole.service...

ssh -c "ssh -o 'StrictHostKeyChecking=no' pi@%PiIp% 'sudo systemctl restart rathole && sudo systemctl restart rathole-client'      "

echo Config Updated successfully.