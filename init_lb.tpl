#!/bin/bash
echo "Start of boot script"
export FACTER_monitor_address="${monitor_address}"
export FACTER_member_ips="${appl1_address};${appl2_address};${appl3_address};${appl4_address}"
export FACTER_member_names="${appl1_name};${appl2_name};${appl3_name};${appl4_name}"
echo "Members are: $FACTER_member_names, $FACTER_member_ips"

mkdir -p /etc/puppetlabs/puppet
mkdir -p /etc/puppetlabs/code/environments/production/hieradata

echo "Write hiera.yaml /etc/puppetlabs/puppet/hiera.yaml"
cat <<'EOF' >> /etc/puppetlabs/puppet/hiera.yaml
---
:backends:
  - json
  - yaml
:hierarchy:
  - "nodes/%{::trusted.certname}"
  - customer
  - relybv
  - common

:yaml:
  :datadir: "/etc/puppetlabs/code/environments/production/hieradata"
:json:
  :datadir: "/etc/puppetlabs/code/environments/production/hieradata"
EOF

echo "Write customer hieradata"
echo '${file("customer.json")}' > "/etc/puppetlabs/code/environments/production/hieradata/customer.json"

echo "Write pem file"


echo "Bootstrap puppet and apply role"
wget https://raw.githubusercontent.com/relybv/dirict-role_lb/master/files/bootme.sh && bash bootme.sh
