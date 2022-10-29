.PHONY: build shell create-dirs restart upgrade upgrade-pihole

# Edit DOCKER_OVERRIDE if using a different upstream VPN config
DOCKER_OVERRIDE=docker-compose.proton.yml

DOCKER_COMPOSE_ARGS=-f docker-compose.yml -f ${DOCKER_OVERRIDE}

build: create-dirs
	docker-compose ${DOCKER_COMPOSE_ARGS} build

build-no-cache: create-dirs
	docker-compose ${DOCKER_COMPOSE_ARGS} build --no-cache

pritunl-shell:
	docker-compose ${DOCKER_COMPOSE_ARGS} exec pritunl /bin/bash

pihole-shell:
	docker-compose ${DOCKER_COMPOSE_ARGS} exec pihole /bin/bash

up: create-dirs
	docker-compose ${DOCKER_COMPOSE_ARGS} up -d

down:
	docker-compose ${DOCKER_COMPOSE_ARGS} down --remove-orphans

logs:
	docker-compose ${DOCKER_COMPOSE_ARGS} logs -f

vpn-logs:
	docker-compose ${DOCKER_COMPOSE_ARGS} logs -f vpn

pritunl-logs:
	docker-compose ${DOCKER_COMPOSE_ARGS} exec pritunl tail -n 500 -f /var/log/pritunl.log

pihole-logs:
	docker-compose ${DOCKER_COMPOSE_ARGS} logs -f pihole

cloudflared-logs:
	docker-compose ${DOCKER_COMPOSE_ARGS} logs -f cloudflared

cloudflared-shell:
	docker-compose ${DOCKER_COMPOSE_ARGS} exec cloudflared /bin/bash

create-dirs:
	mkdir -p pritunl/mongodb pritunl/pritunl
	touch pritunl/pritunl.conf

restart: down up

upgrade-pihole:
	docker pull pihole/pihole

upgrade-pritunl:
	docker pull kyokley/pritunl

upgrade: upgrade-pihole upgrade-pritunl build restart
