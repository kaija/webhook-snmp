
.PHONY: image run debug
all: image

image:
	docker build -t kaija/webhook-snmp .

run:
	docker run -p 161:161/udp -p 80:80/tcp kaija/webhook-snmp

debug:
	docker run -it -p 161:161/udp -p 80:80/tcp -e SNMP_SERVER=10.211.55.43 kaija/webhook-snmp /bin/bash
