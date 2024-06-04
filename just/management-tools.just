# vim: set ft=make :
########################
### management-tools.just
########################
## Standardized verbs
# configure- = configure something that is pre-installed on the image
# install-   = install something, no uninstall or configuration provided
# setup-     = install something and also provide configuration and/or uninstallation options
# toggle-    = turn something on/off, logic can be automatic or manual selection
# fix-       = apply fix/patch/workaround for something
# foo        = no verb is used for shortcuts or something deemed important enough to use a super memorable name

# Setup Management
manage ACTION="":
    #!/bin/bash
    OPTION={{ ACTION }}
    if [ "$OPTION" == "help" ]; then
        echo "Usage: ujust manage <option>"
        echo "  <option>: Specify the ip of the wazuh server for management"
        exit 0
    elif [ "$OPTION" == "" ]; then
        echo "Usage: ujust manage <option>"
        echo "  <option>: Specify the ip of the wazuh server for management"
        exit 0
    fi 
    if [[ "$OPTION" =~ [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} ]]; then
        echo 'Setting up Wazuh'
        sudo podman run -v /tmp:/tmp -w /tmp --rm --privileged registry.fedoraproject.org/fedora:latest /bin/bash -c "curl -o wazuh-agent-4.7.3-1.x86_64.rpm https://packages.wazuh.com/4.x/yum/wazuh-agent-4.7.3-1.x86_64.rpm && sudo WAZUH_MANAGER=$OPTION rpm -ihv wazuh-agent-4.7.3-1.x86_64.rpm && cp -r /var/ossec /tmp/ossec"
        sudo mv /tmp/ossec /var/ossec
        sudo groupadd -r wazuh
        sudo useradd -g wazuh -G wazuh -d /var/ossec -r -s /sbin/nologin wazuh
        sudo chown -R wazuh:wazuh /var/ossec
        sudo systemctl enable --now wazuh-agent.service
    else
        echo 'Address must be an IPv4 address.'
        exit 0

# Remove Management
unmanage:
    echo 'Removing Wazuh'
    sudo /var/ossec/bin/wazuh-control stop
    sudo rm -rf /var/ossec
    sudo userdel wazuh
    sudo groupdel wazuh

# Install NIX
install-nix:
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
