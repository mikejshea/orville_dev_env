## Dashboard VirtualBox

### Install Packer
Packer is a small go app, that really does not require installing. For this project, I put the executable in my folder with all the packer files. You will need to adjust accordingly.

https://www.packer.io/

### CentOS 7 - 1708
Download the 1708 iso build of CentOS-7 Minimal and put is somewhere you can easily access it.

http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1708.iso

### Update variables
In the centos-iso-vbox folder you will need to update the `vars.json` file to reflect your specific needs.

### Create VM
From the centos-iso-vbox, use the command below to run the packer install.
```
packer build --var-file vars.json --force base.json
```
The `--force` will delete any old virtual machines sitting in the destination folder.

Building the VM can take quite a while.

### Post install

> NOTE: X-Pack is currently not installed. Therefore account passwords and the "post_install.sh" script are not needed.

1. In VirtualBox, import the new appliance pointing to the `OVF` file created in the destination folder.
1. Start the new virtual machine.
1. Login with `root` and the initial password `dashboard`.
1. Setup Networking for the VM instance
  - There are two options here: NAT with Port Forwarding or Bridged.
    - Bridged will enable the VM to get an IP address from your network's DHCP server
      - Each time the VM gets an IP address you'll need to find out what the IP is (hint `ip addr`)
      - The service endpoints on the VM instance would then be accessible at that IP address
    - NAT with Port Forwarding will assign the VM an IP address managed by VirtualBox, but...
      - Port Forwarding would allow you to access the service endpoints using your localhost address
      - Thus avoiding needing to know the IP address of the VM instance and ensuring a consistent endpoint regardless of the VM instance IP
  - See instructions below to setup either Bridged or NAT with Port Forwarding
    > NOTE: This configuration could likely be automated via Packer

#### NAT with Port Forwarding

1. Open "Settings" for the VM instance
1. Click on "Network"
1. Select "NAT" in the "Attached to" option
1. Click the "Advanced" section expand icon to reveal the "Port Forwarding" button
1. Click the "Port Forwarding" button
1. Use the "Add" button to add the following configurations
   - Name: ElasticSearch
    - Protocol: TCP
    - Host IP: 127.0.0.1
    - Host Port: 9200
    - Guest IP: [_leave blank_]
    - Guest Port: 9200
  - Name : Kibana
    - Protocol: TCP
    - Host IP: 127.0.0.1
    - Host Port: 5601
    - Guest IP: [_leave blank_]
    - Guest Port: 5601
  - Name: SSH
    - Protocol: TCP
    - Host IP: 127.0.0.1
    - Host Port: 2222
    - Guest IP: [_leave blank_]
    - Guest Port: 22
1. Click the "OK" button, and click the "OK" button on the "Settings" dialog to save the changes

#### Bridged

1. Open "Settings" for the VM instance
1. Click on "Network"
1. Select "Bridged" in the "Attached to" option
1. Click the "OK" button
1. You'll now need to know the IP address of the VM instance to access it (use `ip addr` from a console session within the VM to obtain this)

### Endpoints

- http://localhost:9200 - ElasticSearch
- http://localhost:5601 - Kibana

