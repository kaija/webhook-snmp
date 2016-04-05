#/bin/sh
hostname='localhost'
trap_name='TEST_SERVCE'
status=0
comment="test message"

/usr/bin/snmptrap -v 2c -c public 10.211.55.2 "" NAGIOS-NOTIFY-MIB::nSvcEvent nSvcHostname s "$hostname" nSvcDesc s "$trap_name" nSvcStateID i $status nSvcOutput s "test message";
