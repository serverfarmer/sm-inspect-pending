#!/bin/sh
. /opt/farm/scripts/init

out=/var/cache/farm
command="/opt/farm/ext/packages/utils/pending.sh"

for server in `/opt/farm/mgr/inspect-pending/utils/get-hosts.sh`; do

	host=`/opt/farm/ext/farm-manager/internal/decode.sh host $server`
	port=`/opt/farm/ext/farm-manager/internal/decode.sh port $server`

	sshkey=`/opt/farm/ext/keys/get-ssh-management-key.sh $host`
	ssh -i $sshkey -p $port -o StrictHostKeyChecking=no root@$host "$command" \
		|/opt/farm/ext/versioning/save.sh daily 0 $out pending-$host.list

done

"$command" |/opt/farm/ext/versioning/save.sh daily 0 $out pending-$HOST.list
