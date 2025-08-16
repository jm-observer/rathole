docker run --rm -it %AARCH64_IMAGE% ^
    sh -c "cat ~/.ssh/id_rsa.pub | ssh pi@%PiIp% 'cat >> /home/pi/.ssh/authorized_keys'" 