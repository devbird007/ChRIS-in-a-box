# set locale defaults for the Install
lang en_US.UTF-8
keyboard us
timezone UTC

# initialize any invalid partition tables and destroy all of their contents
zerombr

# erase all disk partitions and create a default label
clearpart --all --initlabel

# automatically create xfs partitions with no LVM and no /home partition
autopart --type=plain --fstype=xfs --nohome

# reboot after installation is successfully completed
reboot

# installation will run in text mode
text

# activate network devices and configure with DHCP
network --bootproto=dhcp

# create default user with sudo privileges
user --name={{ rfe_user | default('core') }} --groups=wheel --password={{ rfe_password | default('edge') }}

# set up the OSTree-based install with disabled GPG key verification, the base
# URL to pull the installation content, 'rhel' as the management root in the
# repo, and 'rhel/8/x86_64/edge' as the branch for the installation
ostreesetup --nogpg --url={{ rfe_tarball_url }}/repo/ --osname=rhel --remote=edge --ref=rhel/8/x86_64/edge

%post

# Set the update policy to automatically download and stage updates to be
# applied at the next reboot
#stage updates as they become available. This is highly recommended
echo AutomaticUpdatePolicy=stage >> /etc/rpm-ostreed.conf

cat > /etc/systemd/system/chrisinabox.service << 'EOF'

[Unit]
Description=Deploy Chris in a box using Podman
After=network.target

[Service]
Type=simple
User=admin    # Replace with the desired user who should run the service
ExecStart=/path/to/git_clone_and_run.sh
WorkingDirectory=/path/to/clone/dir   # Replace with the same directory used in the shell script

[Install]
WantedBy=multi-user.target



systemctl enable chrisinabox.service


%end