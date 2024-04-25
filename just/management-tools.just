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
manage:
    echo 'Setting up Wazuh'
    podman run -v /tmp:/tmp -w /tmp registry.fedoraproject.org/fedora:latest curl -o wazuh-agent-4.7.3-1.x86_64.rpm https://packages.wazuh.com/4.x/yum/wazuh-agent-4.7.3-1.x86_64.rpm && sudo WAZUH_MANAGER='100.67.133.75' rpm -ihv wazuh-agent-4.7.3-1.x86_64.rpm && cp -r /var/ossec /tmp/ossec
    sudo mv /tmp/ossec /var/ossec
    sudo groupadd wazuh
    sudo adduser wazuh
    chown -R wazuh:wazuh /var/ossec
    sudo systemctl enable --now wazuh-agent.service

# Remove Management
unmanage:
    echo 'Removing Wazuh'
    sudo /var/ossec/bin/wazuh-control stop
    sudo rm -rf /var/ossec
    sudo groupdel wazuh
    sudo userdel wazuh