mkdir -p /data/ansible/

echo "Change Directory Color"
echo "LS_COLORS=\$LS_COLORS:'di=0;35:' ; export LS_COLORS" >> ~/.bashrc

mkdir ~/.ssh
touch ~/.ssh/known_hosts
ssh-keyscan -H localhost >> ~/.ssh/known_hosts
