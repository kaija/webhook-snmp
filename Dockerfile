FROM ubuntu

RUN apt-get update && apt-get install -y curl && curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -

RUN apt-get install -y nodejs
RUN apt-get install -y snmp snmpd snmptt wget patch smistrip vim

COPY packages/snmp-mibs-downloader_1.1_all.deb /var/cache/apt/archives/
RUN dpkg -i /var/cache/apt/archives/snmp-mibs-downloader_1.1_all.deb
COPY scripts/setup_snmpd.sh /usr/local/bin/
COPY scripts/run.sh /usr/src/app/run.sh
COPY scripts/node_snmptrap /usr/bin/node_snmptrap
COPY templates/snmpd.conf /root/snmpd.conf
COPY templates/snmptt.ini /etc/snmp/
COPY templates/snmptt.conf /etc/snmp/
COPY templates/NAGIOS-NOTIFY-MIB /usr/share/snmp/mibs/
COPY templates/NAGIOS-ROOT-MIB /usr/share/snmp/mibs/
COPY templates/test.sh /usr/src/app/test.sh

COPY app /usr/src/app
WORKDIR /usr/src/app
RUN npm install
EXPOSE 3000

CMD [ "npm", "start" ]
