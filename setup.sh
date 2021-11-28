#!/bin/sh

/opt/farm/scripts/setup/extension.sh sf-versioning
/opt/farm/scripts/setup/extension.sh sm-farm-manager

echo "setting up base directories and files"
mkdir -p ~/.serverfarmer/inspection
chmod 0710 ~/.serverfarmer ~/.serverfarmer/inspection
chown root:www-data ~/.serverfarmer ~/.serverfarmer/inspection

if ! grep -q /opt/farm/mgr/inspect-pending/cron /etc/crontab; then
	echo "40 7 * * * root /opt/farm/mgr/inspect-pending/cron/inspect.sh" >>/etc/crontab
fi
