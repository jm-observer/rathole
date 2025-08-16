@echo off
echo Deploying config and service to %PiIp%...

echo Creating rathole directory if not exists...
ssh pi@%PiIp% "mkdir -p ~/rathole"

echo Uploading config...
scp -o "StrictHostKeyChecking=no" ./resource/client.toml pi@%PiIp%:~/rathole/
scp -o "StrictHostKeyChecking=no" ./resource/server.toml pi@%PiIp%:~/rathole/

echo Installing rathole.service...
scp -o "StrictHostKeyChecking=no" ./resource/rathole.service pi@%PiIp%:/tmp/rathole.service
scp -o "StrictHostKeyChecking=no" ./resource/rathole-client.service pi@%PiIp%:/tmp/rathole-client.service
ssh pi@%PiIp% "sudo cp /tmp/rathole.service /etc/systemd/system/ && sudo systemctl daemon-reload && sudo systemctl enable rathole.service"
ssh pi@%PiIp% "sudo cp /tmp/rathole-client.service /etc/systemd/system/ && sudo systemctl daemon-reload && sudo systemctl enable rathole-client.service"

echo Config and service deployed successfully. 