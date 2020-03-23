#!/bin/sh

if grep -q /opt/farm/mgr/inspect-pending/cron /etc/crontab; then
	sed -i -e "/\/opt\/farm\/mgr\/inspect-pending\/cron/d" /etc/crontab
fi
