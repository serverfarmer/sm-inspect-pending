#!/bin/sh

/opt/farm/scripts/setup/extension.sh sf-versioning
/opt/farm/scripts/setup/extension.sh sf-farm-manager

echo "setting up base directories and files"
mkdir -p   /var/cache/farm
chmod 0710 /var/cache/farm
chown root:www-data /var/cache/farm

if ! grep -q /opt/farm/ext/inspect-pending/cron /etc/crontab; then
	echo "40 7 * * * root /opt/farm/ext/inspect-pending/cron/inspect.sh" >>/etc/crontab
fi
