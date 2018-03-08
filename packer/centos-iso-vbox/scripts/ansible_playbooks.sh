echo" Staring Ansible Scripts"
cd /data/ansible
ansible-playbook -i inventory/orville-local orville.yml
echo "Ending Ansible Scripts"
