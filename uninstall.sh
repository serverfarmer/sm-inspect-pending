#!/bin/sh

if grep -q /opt/farm/ext/inspect-pending/cron /etc/crontab; then
	sed -i -e "/\/opt\/farm\/ext\/inspect-pending\/cron/d" /etc/crontab
fi
