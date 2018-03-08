function AnsibleVaultFile()
{
	v_pwd="orville"
	echo $v_pwd > ~/vault_pass.txt
}
function InstallAnsible {
    echo Start Ansible
    yum -y install ansible
    yum -y install python-jmespath
    AnsibleVaultFile
    echo Finished Ansible
}

InstallAnsible
