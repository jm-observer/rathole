docker run --rm -it -v %cd%:/root/src ^
    %AARCH64_IMAGE% ^
    sh -c "ssh -o 'StrictHostKeyChecking=no' pi@%PiIp% 'sudo systemctl stop rathole && sudo systemctl stop rathole-client && cp -f /tmp/%C_APP% /home/pi/%C_APP% && sudo systemctl start rathole && sudo systemctl start rathole-client'      "