
.PHONY: image run debug
all: image

image:
	docker build -t kaija/webhook-snmp .

webhook:
	docker run -p 9999:9999/tcp --name webhook kaija/webhook-snmp

debug_webhook:
	docker run -it -p 9999:9999/tcp -e SNMP_SERVER=10.211.55.43 --name webhook kaija/webhook-snmp /bin/bash
