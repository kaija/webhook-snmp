DEFAULT_SERVER=snmpserver

if [ -z "$SNMP_SERVER" ];then
    SNMP_SERVER=$DEFAULT_SERVER
fi

eval "cat  << EOF
$(cat /root/snmpd.conf)
EOF" > /etc/snmp/snmpd.conf
