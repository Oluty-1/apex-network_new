#!/bin/bash



# Activate the virtual environment
source /home/tayo/myvenv/bin/activate

# Run the Ansible playbook
ansible-playbook -i inventory quicktest.yaml