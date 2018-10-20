#!/bin/bash
. /opt/farm/scripts/init
. /opt/farm/scripts/functions.custom


out=/var/cache/farm
path=/etc/local/.farm
command="/opt/farm/ext/packages/utils/pending.sh"
servers=`cat $path/virtual.hosts $path/physical.hosts $path/cloud.hosts $path/lxc.hosts $path/workstation.hosts $path/problematic.hosts |grep -v ^# |grep -v ^$ |grep -v laptop`

for server in $servers; do

	if [[ $server =~ ^[a-z0-9.-]+$ ]]; then
		server="$server::"
	elif [[ $server =~ ^[a-z0-9.-]+[:][0-9]+$ ]]; then
		server="$server:"
	fi

	host=$(echo $server |cut -d: -f1)
	port=$(echo $server |cut -d: -f2)

	if [ "$port" = "" ]; then
		port=22
	fi

	sshkey=`/opt/farm/ext/keys/get-ssh-management-key.sh $host`
	ssh -i $sshkey -p $port -o StrictHostKeyChecking=no root@$host "$command" \
		|/opt/farm/ext/versioning/save.sh daily 0 $out pending-$host.list

done

"$command" |/opt/farm/ext/versioning/save.sh daily 0 $out pending-$HOST.list
