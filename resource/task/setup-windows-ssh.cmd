@echo off
echo Setting up SSH keys on Windows for Pi access...

echo Fixing SSH host key issue first...
ssh-keygen -R %PiIp%

echo Checking if SSH key exists...
if not exist "%USERPROFILE%\.ssh\id_rsa" (
    echo SSH key not found, generating new one...
    ssh-keygen -t rsa -b 4096 -f "%USERPROFILE%\.ssh\id_rsa" -N ""
    echo SSH key generated successfully.
) else (
    echo SSH key already exists.
)

echo Creating .ssh directory on Pi if not exists...
ssh -o StrictHostKeyChecking=no pi@%PiIp% "mkdir -p ~/.ssh"

echo Copying public key to Pi...
type "%USERPROFILE%\.ssh\id_rsa.pub" | ssh -o StrictHostKeyChecking=no pi@%PiIp% "cat >> ~/.ssh/authorized_keys"

echo Setting correct permissions on Pi...
ssh -o StrictHostKeyChecking=no pi@%PiIp% "chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys"

echo SSH key setup completed. You can now connect to Pi without password. 